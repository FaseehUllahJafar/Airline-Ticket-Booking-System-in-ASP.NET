using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Windows.Forms;

namespace db_Proj_2
{
    public partial class History : System.Web.UI.Page
    {
        string Mainconn = ConfigurationManager.ConnectionStrings["con"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            SqlConnection con = new SqlConnection(Mainconn);
            con.Open();

            //////////SEperate User Admin
            SqlDataAdapter sqlDa = new SqlDataAdapter("Select * from history", con);

            DataTable dtbl = new DataTable();
            sqlDa.Fill(dtbl);

            gridHistory.DataSource = dtbl;
            gridHistory.DataBind();


        }


    }
}