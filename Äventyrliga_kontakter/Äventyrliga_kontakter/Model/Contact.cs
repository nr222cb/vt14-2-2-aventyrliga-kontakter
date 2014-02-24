using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace Äventyrliga_kontakter.Model
{
    public class Contact
    {
        public int ContactId { get; set; }
        [Required(ErrorMessage="En Epostadress måste anges.")]
        [StringLength(50, ErrorMessage="Max 50 tecken.")]
        [RegularExpression(@"^[^@]+@[^@]+\.[^@\.]{2,}$", ErrorMessage = "Ingen äkta epostadress.")]
        public string EmailAddress { get; set; }
        [Required(ErrorMessage = "Förnamnet måste anges.")]
        [StringLength(50, ErrorMessage="Max 50 tecken.")]
        public string FirstName { get; set; }
        [Required(ErrorMessage = "Efternamnet måste anges.")]
        [StringLength(50, ErrorMessage="Max 50 tecken.")]
        public string LastName { get; set; }
    }
}