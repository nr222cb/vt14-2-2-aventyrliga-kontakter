<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Contacts.aspx.cs" Inherits="Äventyrliga_kontakter.Contacts" ViewStateMode="Disabled" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Äventyrliga kontakter</title>
    <link rel="stylesheet" href="Content/StyleSheet.css" />
</head>
<body>
    <h1>Äventyrliga kontakter</h1>
    <form id="form1" runat="server">
        <div class="datagrid">
            <asp:Panel runat="server" ID="MessagePanel" Visible="false" CssClass="green">
                <asp:Literal runat="server" ID="MessageLiteral" />
            </asp:Panel>
            <asp:ValidationSummary ID="ValidationSummary" runat="server" HeaderText="Fel inträffade. Korrigera det som är fel och försök igen." ValidationGroup="Edit" CssClass="red" />
            <asp:ValidationSummary ID="ValidationSummary1" runat="server" HeaderText="Fel inträffade. Korrigera det som är fel och försök igen." ValidationGroup="Insert" CssClass="red" />
            <asp:ListView ID="ContactListView" runat="server"
                ItemType="Äventyrliga_kontakter.Model.Contact"
                SelectMethod="ContactListView_GetData"
                InsertMethod="ContactListView_InsertItem"
                UpdateMethod="ContactListView_UpdateItem"
                DeleteMethod="ContactListView_DeleteItem"
                DataKeyNames="ContactId"
                InsertItemPosition="FirstItem">
                <LayoutTemplate>
                    <table>
                        <thead>
                            <tr>
                                <th>Förnamn
                                </th>
                                <th>Efternamn
                                </th>
                                <th>Epost
                                </th>
                                <th>Åtgärd
                                </th>
                            </tr>
                        </thead>
                        <%-- Platshållare för nya rader --%>
                        <asp:PlaceHolder ID="itemPlaceholder" runat="server" />
                    </table>
                    <asp:DataPager ID="DataPager" runat="server" PageSize="20">
                        <Fields>
                            <asp:NextPreviousPagerField ShowFirstPageButton="True" ShowLastPageButton="True" FirstPageText="Första" LastPageText="Sista" NextPageText="Nästa" PreviousPageText="Förra" ButtonType="Button" />
                            <asp:NumericPagerField />
                        </Fields>
                    </asp:DataPager>

                </LayoutTemplate>
                <ItemTemplate>
                    <%-- Mall för nya rader. --%>
                    <tr>
                        <td>
                            <asp:Label ID="NameLabel" runat="server" Text='<%#: Item.FirstName %>' />
                        </td>
                        <td>
                            <asp:Label ID="AddressLabel" runat="server" Text='<%#: Item.LastName %>' />
                        </td>
                        <td>
                            <asp:Label ID="PostalCodeLabel" runat="server" Text='<%#: Item.EmailAddress %>' />
                        </td>
                        <td>
                            <asp:LinkButton runat="server" CausesValidation="false" CommandName="Delete" Text="Radera" 
                                OnClientClick="return confirm('Är du säker på att du vill ta bort denna post?');"></asp:LinkButton>
                            <asp:LinkButton runat="server" CausesValidation="false" CommandName="Edit" Text="Redigera"></asp:LinkButton>
                        </td>
                    </tr>
                </ItemTemplate>
                <AlternatingItemTemplate>
                    <tr class="alt">
                        <td>
                            <asp:Label ID="NameLabel" runat="server" Text='<%#: Item.FirstName %>' />
                        </td>
                        <td>
                            <asp:Label ID="AddressLabel" runat="server" Text='<%#: Item.LastName %>' />
                        </td>
                        <td>
                            <asp:Label ID="PostalCodeLabel" runat="server" Text='<%#: Item.EmailAddress %>' />
                        </td>
                        <td>
                            <asp:LinkButton runat="server" CausesValidation="false" CommandName="Delete" Text="Radera"
                                OnClientClick="return confirm('Är du säker på att du vill ta bort denna post?');"></asp:LinkButton>
                            <asp:LinkButton runat="server" CausesValidation="false" CommandName="Edit" Text="Redigera"></asp:LinkButton>
                        </td>
                    </tr>
                </AlternatingItemTemplate>
                <EmptyDataTemplate>
                    <%-- Detta visas då kontaktuppgifter saknas i databasen. --%>
                    <p>
                        Kontaktuppgifter saknas.
                    </p>
                </EmptyDataTemplate>
                <InsertItemTemplate>
                    <%-- Mall för rad i tabellen för att lägga till nya kontaktuppgifter. Visas bara om InsertItemPosition 
                     har värdet FirstItemPosition eller LasItemPosition.--%>
                    <tr>
                        <td>
                            <asp:TextBox ID="FirstName" runat="server" Text='<%# BindItem.FirstName %>' MaxLength="50" CausesValidation="True" ValidationGroup="Insert"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Förnamn måste anges." ControlToValidate="FirstName" Text="*" Display="Dynamic" SetFocusOnError="True" ValidationGroup="Insert"></asp:RequiredFieldValidator>
                        </td>
                        <td>
                            <asp:TextBox ID="LastName" runat="server" Text='<%# BindItem.LastName %>' MaxLength="50" CausesValidation="True" ValidationGroup="Insert"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Efternamn måste anges." ControlToValidate="LastName" Font-Bold="False" Display="Dynamic" SetFocusOnError="True" Text="*" ValidationGroup="Insert"></asp:RequiredFieldValidator>
                        </td>
                        <td>
                            <asp:TextBox ID="EmailAddress" runat="server" Text='<%# BindItem.EmailAddress %>' MaxLength="50" CausesValidation="True" ValidationGroup="Insert"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="Epost måste anges." ControlToValidate="EmailAddress" Display="Dynamic" Text="*" ValidationGroup="Insert"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="Giltig epost måste anges." ValidationExpression="^[^@]+@[^@]+\.[^@\.]{2,}$" SetFocusOnError="True" ControlToValidate="EmailAddress" Display="Dynamic" EnableClientScript="True" Text="*" ValidationGroup="Insert"></asp:RegularExpressionValidator>
                        </td>
                        <td>
                            <asp:LinkButton runat="server" CommandName="Insert" Text="Lägg till" ValidationGroup="Insert"></asp:LinkButton>
                            <asp:LinkButton runat="server" CausesValidation="false" CommandName="Cancel" Text="Rensa"></asp:LinkButton>
                        </td>
                    </tr>
                </InsertItemTemplate>
                <EditItemTemplate>
                    <tr>
                        <td>
                            <asp:TextBox ID="FirstNameEdit" runat="server" Text='<%# BindItem.FirstName %>' ValidationGroup="Edit"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="Förnamn måste anges." ControlToValidate="FirstNameEdit" Text="*" Display="Dynamic" SetFocusOnError="True" ValidationGroup="Edit"></asp:RequiredFieldValidator>                        
                        </td>
                        <td>
                            <asp:TextBox ID="LastNameEdit" runat="server" Text='<%# BindItem.LastName %>'></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ErrorMessage="Efternamn måste anges." ControlToValidate="LastNameEdit" Font-Bold="False" Display="Dynamic" SetFocusOnError="True" Text="*" ValidationGroup="Edit"></asp:RequiredFieldValidator>
                        </td>
                        <td>
                            <asp:TextBox ID="EmailAddressEdit" runat="server" Text='<%# BindItem.EmailAddress %>'></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ErrorMessage="Epost måste anges." ControlToValidate="EmailAddressEdit" Display="Dynamic" Text="*" ValidationGroup="Edit"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ErrorMessage="Giltig epost måste anges." ValidationExpression="^[^@]+@[^@]+\.[^@\.]{2,}$" SetFocusOnError="True" ControlToValidate="EmailAddressEdit" Display="Dynamic" EnableClientScript="True" Text="*" ValidationGroup="Edit"></asp:RegularExpressionValidator>                        
                        </td>
                        <td>
                            <%-- Knappar för uppdatera en kontaktuppgift och avbryta. --%>
                            <asp:LinkButton runat="server" CommandName="Update" Text="Spara" ValidationGroup="Edit"></asp:LinkButton>
                            <asp:LinkButton runat="server" CommandName="Cancel" Text="Ångra" CausesValidation="false"></asp:LinkButton>
                        </td>
                    </tr>
                </EditItemTemplate>
            </asp:ListView>
        </div>
    </form>
</body>
</html>
