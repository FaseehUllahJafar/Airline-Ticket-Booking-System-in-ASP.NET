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
    public partial class Discount : System.Web.UI.Page
    {
        string Mainconn = ConfigurationManager.ConnectionStrings["con"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                cascadingdropdown();
            }
        }

        protected void cascadingdropdown()
        {
            SqlConnection sqlconn = new SqlConnection(Mainconn);
            sqlconn.Open();
            SqlCommand sqlcomm = new SqlCommand("select* from discounts", sqlconn);

            sqlcomm.CommandType = CommandType.Text;
            TextBox2.DataSource = sqlcomm.ExecuteReader();
            TextBox2.DataTextField = "offer";

            TextBox2.DataBind();
            TextBox2.Items.Insert(0, new ListItem("--Select Offer--", "0"));

        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            try
            {
                SqlConnection con = new SqlConnection(Mainconn);

                SqlCommand cmd = new SqlCommand("edit_discounts", con);

                cmd.CommandType = System.Data.CommandType.StoredProcedure;


                int stat = 0;
                if (TextBox1.Text == "Enable")
                {
                    stat = 1;
                }
                else
                {
                    stat = 0;
                }

                cmd.Parameters.AddWithValue("@status", stat);
                cmd.Parameters.AddWithValue("@name", TextBox2.Text);
                cmd.Parameters.AddWithValue("@percent", TextBox3.Text);


                SqlParameter ret = new SqlParameter();
                ret.ParameterName = "@ret";
                ret.SqlDbType = System.Data.SqlDbType.Int;
                ret.Direction = System.Data.ParameterDirection.Output;
                cmd.Parameters.Add(ret);

                con.Open();
                cmd.ExecuteNonQuery();
                //  cmd.BeginExecuteNonQuery();

                string temp = ret.Value.ToString();
                int a = int.Parse(temp);
                if (a == 0)
                {
                    Response.Write("<script>alert('Updated Successfully');</script>");
                }
              
                else 
                {
                    Response.Write("<script>alert('Some Error Happened');</script>");
                }

            }
            catch(Exception ex)
            {
                Response.Write("<script>alert('here " + ex.Message + "');</script>");
            }
        }
    }
}