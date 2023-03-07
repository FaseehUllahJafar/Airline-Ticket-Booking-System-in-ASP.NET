using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;

namespace db_Proj_2
{
    public partial class Edit_Price : System.Web.UI.Page
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
            SqlCommand sqlcomm = new SqlCommand("select * from airplane", sqlconn);

            sqlcomm.CommandType = CommandType.Text;
            DropDownList1.DataSource = sqlcomm.ExecuteReader();
            DropDownList1.DataTextField = "airplane_id";

            DropDownList1.DataBind();
            DropDownList1.Items.Insert(0, new ListItem("--Plane ID--", "0"));

        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            try
            {
                SqlConnection con = new SqlConnection(Mainconn);

                SqlCommand cmd = new SqlCommand("edit_classprice", con);

                cmd.CommandType = System.Data.CommandType.StoredProcedure;



                cmd.Parameters.AddWithValue("@airplane_id", DropDownList1.Text);
                cmd.Parameters.AddWithValue("@class_name", TextBox2.Text);
                cmd.Parameters.AddWithValue("@money", TextBox1.Text);


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
            catch (Exception ex)
            {
                Response.Write("<script>alert('here " + ex.Message + "');</script>");
            }
        }

      
    }
}