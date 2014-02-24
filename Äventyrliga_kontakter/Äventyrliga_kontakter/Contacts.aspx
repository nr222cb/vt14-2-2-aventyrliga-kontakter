﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Contacts.aspx.cs" Inherits="Äventyrliga_kontakter.Contacts" ViewStateMode="Disabled" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Äventyrliga kontakter</title>
    <link rel="stylesheet" href="Content/StyleSheet.css"/>
</head>
<body>
    <h1>Äventyrliga kontakter</h1>
    <form id="form1" runat="server">
        <div class="datagrid">
            <asp:ValidationSummary ID="ValidationSummary" runat="server" HeaderText="Fel inträffade. Korrigera det som är fel och försök igen." />
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
                            <asp:LinkButton runat="server" CausesValidation="false" CommandName="Delete" Text="Radera"></asp:LinkButton>
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
                            <asp:LinkButton runat="server" CausesValidation="false" CommandName="Delete" Text="Radera"></asp:LinkButton>
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
                            <asp:TextBox ID="FirstName" runat="server" Text='<%# BindItem.FirstName %>'></asp:TextBox>
                        </td>
                        <td>
                            <asp:TextBox ID="LastName" runat="server" Text='<%# BindItem.LastName %>'></asp:TextBox>
                        </td>
                        <td>
                            <asp:TextBox ID="EmailAddress" runat="server" Text='<%# BindItem.EmailAddress %>'></asp:TextBox>
                        </td>
                        <td>
                            <asp:LinkButton runat="server" CommandName="Insert" Text="Lägg till"></asp:LinkButton>
                            <asp:LinkButton runat="server" CausesValidation="false" CommandName="Cancel" Text="Rensa"></asp:LinkButton>
                        </td>
                    </tr>
                </InsertItemTemplate>
            </asp:ListView>
        </div>
    </form>
</body>
</html>
