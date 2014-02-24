using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Äventyrliga_kontakter.Model;

namespace Äventyrliga_kontakter
{
    public partial class Contacts : System.Web.UI.Page
    {
        private Service _service;

        private Service Service
        {
            get { return _service ?? (_service = new Service()); }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (HasMessage)
            {
                Literal1.Visible = true;
                Literal1.Text = Message;
            }
        }

        // sessionsvariabel för felmeddelande
        public string Message
        {
            get
            {
                var message = Session["message"] as string;
                Session.Remove("message");
                return message;
            }

            set { Session["message"] = value; }
        }

        private bool HasMessage
        {
            get { return Session["message"] != null; }
        }

        public IEnumerable<Äventyrliga_kontakter.Model.Contact> ContactListView_GetData(int maximumRows, int startRowIndex, out int totalRowCount)
        {
            return Service.GetContactsPageWise(maximumRows, startRowIndex, out totalRowCount);
        }

        public void ContactListView_InsertItem(Contact contact)
        {
            if (IsValid)
            {
                try
                {
                    TryUpdateModel(contact);
                    if (ModelState.IsValid)
                    {
                        Service.SaveContact(contact);
                        Message = String.Format("Kontakten {0} {1} har sparats.", contact.FirstName, contact.LastName);
                        Response.Redirect(Request.Path);
                    }
                }
                catch (Exception)
                {
                    ModelState.AddModelError(String.Empty, "Ett oväntat fel inträffade då kontaktuppgiften skulle läggas till.");
                }
            }
        }

        // The id parameter name should match the DataKeyNames value set on the control
        public void ContactListView_UpdateItem(int contactId)
        {
            if (IsValid)
            {
                try
                {
                    var contact = Service.GetContact(contactId);
                    if (contact == null)
                    {
                        // The item wasn't found
                        ModelState.AddModelError("", String.Format("Kontakten med kontaktnummer {0} hittades inte.", contactId));
                        return;
                    }
                    TryUpdateModel(contact);
                    if (ModelState.IsValid)
                    {
                        Service.SaveContact(contact);
                    }
                }
                catch (Exception)
                {
                    ModelState.AddModelError(String.Empty, "Ett oväntat fel inträffade då kontaktuppgiften skulle uppdateras.");
                }
            }
        }

        // The id parameter name should match the DataKeyNames value set on the control
        public void ContactListView_DeleteItem(int contactId)
        {
            try
            {
                Service.DeleteContact(contactId);
            }
            catch (Exception)
            {
                ModelState.AddModelError(String.Empty, "Ett oväntat fel inträffade då kontaktuppgiften skulle tas bort.");
            }
        }

    }
}