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
    public partial class bookings : System.Web.UI.Page
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
            SqlCommand sqlcomm = new SqlCommand("select* from airport", sqlconn);

            sqlcomm.CommandType = CommandType.Text;
            DropDownList1.DataSource = sqlcomm.ExecuteReader();
            DropDownList1.DataTextField = "city";
            DropDownList1.DataValueField = "airport_code";
            DropDownList1.DataBind();
            DropDownList1.Items.Insert(0, new ListItem("--Select Departure City--", "0"));


        }

        protected void DropDownList1_SelectedIndexChanged1(object sender, EventArgs e)
        {
            int code = Convert.ToInt32(DropDownList1.SelectedValue);
            SqlConnection sqlconn = new SqlConnection(Mainconn);
            sqlconn.Open();
            SqlCommand Sqlcomm = new SqlCommand("select * from airport where airport_code!=" + code, sqlconn);
            Sqlcomm.CommandType = CommandType.Text;
            TextBox2.DataSource = Sqlcomm.ExecuteReader();
            TextBox2.DataTextField = "city";
            TextBox2.DataValueField = "airport_code";
            TextBox2.DataBind();
            TextBox2.Items.Insert(0, new ListItem("--Select Destination City--", "0"));
        }


        protected void TextBox2_SelectedIndexChanged(object sender, EventArgs e)
        {
            int depcode = Convert.ToInt32(DropDownList1.SelectedValue);
            int descode = Convert.ToInt32(TextBox2.SelectedValue);


            SqlConnection sqlconn = new SqlConnection(Mainconn);
            sqlconn.Open();
            SqlCommand Sqlcomm = new SqlCommand("select* from airplane where destination_airport=" + descode + " and  departure_airport=" + depcode, sqlconn);
            Sqlcomm.CommandType = CommandType.Text;
            DropDownList2.DataSource = Sqlcomm.ExecuteReader();

            DropDownList2.DataTextField = "flight_DateTime";
            DropDownList2.DataBind();
            DropDownList2.Items.Insert(0, new ListItem("--Select Time--", "0"));
        }



        protected void Button1_Click(object sender, EventArgs e)
        {
            try
            {
                SqlConnection con = new SqlConnection(Mainconn);

                SqlCommand cmd = new SqlCommand("add_booking", con);

                cmd.CommandType = System.Data.CommandType.StoredProcedure;


                cmd.Parameters.AddWithValue("@seat_class", DropDownList3.Text);
                cmd.Parameters.AddWithValue("@no_of_seats", TextBox3.Text);
                cmd.Parameters.AddWithValue("@cnic", memberid_TextBox1.Text);
                cmd.Parameters.AddWithValue("@flight_dateTime", DropDownList2.Text);
                cmd.Parameters.AddWithValue("@destination_city", TextBox2.Text);
                cmd.Parameters.AddWithValue("@departure_city", DropDownList1.Text);


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

                else if (a == 2)
                {
                    Response.Write("<script>alert('Number of Required Seats are not available');</script>");
                }
                else if (a == 3)
                {
                    Response.Write("<script>alert('Wrong Number of Seats');</script>");
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