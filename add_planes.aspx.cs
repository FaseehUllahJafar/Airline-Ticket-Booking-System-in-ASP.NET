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
    public partial class add_planes : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Button3_Click(object sender, EventArgs e)
        {
            try
            {
                string strcon = ConfigurationManager.ConnectionStrings["con"].ConnectionString;

                using (SqlConnection con = new SqlConnection(strcon))
                {


                    SqlCommand cmd = new SqlCommand("add_airplane", con);

                    cmd.CommandType = System.Data.CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@id", memberid_TextBox1.Text);
                    cmd.Parameters.AddWithValue("@flight_date_time", date_time_TextBox2.Text);
                    cmd.Parameters.AddWithValue("@destination_airport", destination_TextBox.Text);
                    cmd.Parameters.AddWithValue("@departure_airport", destination_TextBox.Text);


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
                        Response.Write("<script>alert('Plane Added Successfully');</script>");
                    }
                    // 1
                    else if(a==1)
                    {
                        Response.Write("<script>alert('Plane Addition Failed Plane With this ID Already exists');</script>");
                    }
                    // 2 destination airport
                    else if (a == 2)
                    {
                        Response.Write("<script>alert('Plane Addition Failed Destination AirportNot Already exists');</script>");
                    }
                    // 3 current airport
                    else if (a == 3)
                    {
                        Response.Write("<script>alert('Plane Addition Failed Current AirportNot Already exists');</script>");
                    }
                }
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('here " + ex.Message + "');</script>");
            }
        }





        protected void destination_TextBox_TextChanged(object sender, EventArgs e)
        {

        }
    }
}