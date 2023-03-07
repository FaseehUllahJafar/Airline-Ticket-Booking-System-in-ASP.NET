using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace db_Proj_2
{
    public partial class About : Page
    {
        string strcon = ConfigurationManager.ConnectionStrings["con"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        // user login
        protected void Button1_Click(object sender, EventArgs e)
        {
            try
            {
                SqlConnection con = new SqlConnection(strcon);
                if (con.State == ConnectionState.Closed)
                {
                    con.Open();

                }
                SqlCommand cmd = new SqlCommand("select * from [User]" +
                    " where cnic='" + memberid_TextBox1.Text.Trim() + "' AND password='" + pwd_TextBox2.Text.Trim() + "'", con);
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.HasRows)
                {
                    // Response.Write("<script>alert('Loged IN');</script>");

                    while (dr.Read())
                    {
                        Response.Write("<script>alert(' LogIN Successful');</script>");
                    
                    
                    
                    }
                }
                else
                {
                    Response.Write("<script>alert('Invalid credentials');</script>");
                }

            }
            catch (Exception ex)
            {

            }


        }

      

        protected void pwd_TextBox2_TextChanged(object sender, EventArgs e)
        {

        }

        //protected void pwd_TextBox2_TextChanged(object sender, EventArgs e)
        //{

        //}
    }
}