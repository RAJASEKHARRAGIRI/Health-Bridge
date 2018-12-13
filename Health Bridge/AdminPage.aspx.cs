using iTextSharp.text;
using iTextSharp.text.pdf;
using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using iTextSharp.text.html;
using iTextSharp.text.html.simpleparser;
using ClosedXML.Excel;

namespace Health_Bridge
{
    public partial class AdminPage : System.Web.UI.Page
    {
        MySqlConnection sqlcon = new MySqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);
        public enum MessageType { success, error, info, warning };
        protected void Page_Load(object sender, EventArgs e)
        {
            
              if (Session.Contents.Count == 0 && Session["customerMail"] == null)
              {
                Response.Redirect("index.aspx");
              }
                else if (Session["customerMail"].ToString() != "admin@gmail.com")
                {
                Response.Redirect("index.aspx");
            }
              else
              {
                  welcomeUsername.Text = "Welcome!! " + Session["customerName"];
                if (!Page.IsPostBack)
                {
                     loadData();
                }
           
            }
        }


        protected void logoutCustomer(object sender, EventArgs e)
        {
            // Session.Clear();
            Session.Abandon();
            Response.Redirect("index.aspx");

        }

        protected void ExportToExcelClick(object sender, EventArgs e)
        {
            DataTable dt = new DataTable("DoctorsView");
            
            foreach (TableCell cell in DoctorsView.HeaderRow.Cells)
            {
                dt.Columns.Add(cell.Text);
            }
            foreach (GridViewRow row in DoctorsView.Rows)
            {
                dt.Rows.Add();
                for (int i = 0; i < row.Cells.Count; i++)
                {
                    dt.Rows[dt.Rows.Count - 1][i] = row.Cells[i].Text;
                }
            }
            
           

            using (XLWorkbook wb = new XLWorkbook())
            {
                wb.Worksheets.Add(dt);
                var ws = wb.Worksheets.Add("worksheet");
                ws.Cells("A1").Style.Fill.BackgroundColor = XLColor.Red;

                Response.Clear();
                Response.Buffer = true;
                Response.Charset = "";
                Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
                Response.AddHeader("content-disposition", "attachment;filename=DoctorsList.xlsx");
                using (MemoryStream MyMemoryStream = new MemoryStream())
                {
                    wb.SaveAs(MyMemoryStream);
                    MyMemoryStream.WriteTo(Response.OutputStream);
                    Response.Flush();
                    Response.End();
                }
            }
        }




        /* protected void ExportToExcelClick(object sender, EventArgs e)
         {
             Response.ClearContent();
             Response.Buffer = true;
             Response.AppendHeader("content-disposition", "attachment; filename=DoctorsList.xls");
             Response.ContentType = "application/excel";
             StringWriter sw = new StringWriter();
             HtmlTextWriter htw = new HtmlTextWriter(sw);
             DoctorsView.AllowPaging = false;

             DoctorsView.HeaderRow.ControlStyle.Font.Size = 25;
             DoctorsView.HeaderRow.Style.Add("background-color", "red");
             for (int i=0; i< DoctorsView.HeaderRow.Cells.Count; i++)
             {
                 DoctorsView.HeaderRow.Cells[i].ColumnSpan =2;
                 DoctorsView.ForeColor = System.Drawing.Color.Blue;
             }
             for (int i = 0; i < DoctorsView.Rows.Count; i++)
             {
                 for (int j = 0; j < DoctorsView.Rows[i].Cells.Count; j++)
                 {
                     DoctorsView.Rows[i].Cells[j].Style.Add("background-color", "yellow");
                     DoctorsView.Rows[i].Cells[j].ColumnSpan = 2;
                     DoctorsView.Rows[i].Cells[j].ForeColor = System.Drawing.Color.Blue;
                     DoctorsView.ForeColor = System.Drawing.Color.Blue;  
                 }

             }

             DoctorsView.RenderControl(htw);
             string headerTable = @"<Table><tr><td align='center' colspan='16' rowspan='2' style='font-size:20px;'><b>HEALTH BRIDGE REPORT</b></td></tr></Table>";
             Response.Write(headerTable);
             Response.Write(sw.ToString());
             Response.End();


     }*/



        public void loadData()
        {
            try
            {
                sqlcon.Open();
                MySqlDataAdapter adp = new MySqlDataAdapter("Select HospitalId, HospitalName, DoctorName, Specialization, HospitalLocation,HospitalAddress, Rating,ConsultancyFee from health_bridge_doctors", sqlcon);
                DataSet ds = new DataSet();
                adp.Fill(ds);

                DoctorsView.DataSource = ds;
                DoctorsView.DataBind();

            }
            catch (Exception ex)
            {
                Response.Write("problem with Connection" + ex);
            }
            finally
            {
                sqlcon.Close();
            }
        }



        protected void specializationChanged(object sender, EventArgs e)
        {
            ViewState["specialization"] = specialization.SelectedValue;
            this.GetFilterData();
           // ShowMessage(ViewState["cityName"].ToString() + " Record Successfully Inserted", MessageType.success);
        }
        protected void cityChanged(object sender, EventArgs e)
        {
            ViewState["cityName"] = cities.SelectedValue;
            this.GetFilterData();
            
        }

        public void GetFilterData()
        {

            if (cities.SelectedIndex != 0 && specialization.SelectedIndex != 0)
            {
                ViewState["queryStr"] = "Select HospitalId, HospitalName, DoctorName, Specialization, HospitalLocation,HospitalAddress, Rating,ConsultancyFee from health_bridge_doctors where HospitalLocation='" + cities.SelectedValue + "' AND Specialization='" + specialization.SelectedValue+"'";
            }
            else if (cities.SelectedIndex != 0 && specialization.SelectedIndex == 0)
            {
                ViewState["queryStr"] = "Select HospitalId, HospitalName, DoctorName, Specialization, HospitalLocation,HospitalAddress, Rating,ConsultancyFee from health_bridge_doctors where HospitalLocation='"+cities.SelectedValue+"'";  
            }
            else if (cities.SelectedIndex == 0 && specialization.SelectedIndex != 0) {
                ViewState["queryStr"] = "Select HospitalId, HospitalName, DoctorName, Specialization, HospitalLocation,HospitalAddress, Rating,ConsultancyFee from health_bridge_doctors where  Specialization='"+specialization.SelectedValue+"'";
            }
            else if(cities.SelectedIndex == 0 && specialization.SelectedIndex == 0)
            {
                ViewState["queryStr"] = "Select HospitalId, HospitalName, DoctorName, Specialization, HospitalLocation,HospitalAddress, Rating,ConsultancyFee from health_bridge_doctors where HospitalLocation='" + cities.SelectedValue + "' AND Specialization='" + specialization.SelectedValue + "'";
            }
           // ShowMessage(ViewState["cityName"].ToString() +" ->"+flag+ " Record Successfully Inserted", MessageType.success);
            try
            {
                sqlcon.Open();
                MySqlDataAdapter adp = new MySqlDataAdapter(ViewState["queryStr"].ToString(), sqlcon);
                
                DataSet ds = new DataSet();
                adp.Fill(ds);

                DoctorsView.DataSource = ds;
                DoctorsView.DataBind();
            }
            catch (Exception ex)
            {
                Response.Write("problem with Connection" + ex);
            }
            finally
            {
                sqlcon.Close();
            }
        }


        protected void ExporttoPDF_Click(object sender, EventArgs e)
        {
            ShowMessage("Successfully Export to PDF File", MessageType.success);
            int columnsCount = DoctorsView.HeaderRow.Cells.Count;
            // Create the PDF Table specifying the number of columns
            PdfPTable pdfTable = new PdfPTable(columnsCount);

            // Loop thru each cell in GrdiView header row
            foreach (TableCell gridViewHeaderCell in DoctorsView.HeaderRow.Cells)
            {
                // Create the Font Object for PDF document
                Font font66 = new Font(Font.FontFamily.TIMES_ROMAN, 10.5f, Font.BOLD | Font.NORMAL, BaseColor.WHITE);
                // Set the font color to GridView header row font color
                
                PdfPCell pdfCell = new PdfPCell(new Phrase(gridViewHeaderCell.Text, font66));
                pdfCell.PaddingTop = 7;
                pdfCell.MinimumHeight = 30;
                pdfCell.HorizontalAlignment = 1;
                pdfCell.BackgroundColor = new BaseColor(61, 60, 65);
               

                // Add the cell to PDF table
                pdfTable.AddCell(pdfCell);
            }

            // Loop thru each datarow in GrdiView
            foreach (GridViewRow gridViewRow in DoctorsView.Rows)
            {
                if (gridViewRow.RowType == DataControlRowType.DataRow)
                {
                    // Loop thru each cell in GrdiView data row
                    foreach (TableCell gridViewCell in gridViewRow.Cells)
                    {
                        Font font55 = new Font(Font.FontFamily.TIMES_ROMAN, 10f, Font.NORMAL | Font.NORMAL, BaseColor.BLACK);

                        // Set the font color to GridView header row font color
                       
                        PdfPCell pdfCell = new PdfPCell(new Phrase(gridViewCell.Text, font55));
                        pdfCell.HorizontalAlignment = 1;
                        pdfCell.PaddingTop = 7;
                        pdfCell.MinimumHeight = 30;
                        //pdfCell.Width = 70;
                        pdfCell.BackgroundColor = new BaseColor(DoctorsView.RowStyle.BackColor);

                        pdfTable.AddCell(pdfCell);
                    }
                }
            }

            // Create the PDF document specifying page size and margins
            Document pdfDocument = new Document(PageSize.A4, 5f, 15f, 5f, 5f);
            pdfDocument.SetPageSize(PageSize.A4.Rotate());
            PdfWriter.GetInstance(pdfDocument, Response.OutputStream);

            pdfDocument.Open();
            //Report Header
            
            Font font22 = new Font(Font.FontFamily.TIMES_ROMAN, 12f, Font.NORMAL | Font.NORMAL, BaseColor.BLACK);
            Font font = new Font(Font.FontFamily.TIMES_ROMAN, 20f, Font.NORMAL | Font.NORMAL, BaseColor.BLACK);
            Paragraph prgHeading = new Paragraph();
            prgHeading.Alignment = Element.ALIGN_CENTER;
            prgHeading.Add(new Chunk("\nHEALTH BRIDGE\n", font));
            prgHeading.Add(new Chunk("Digital Medical Service Platform Between Patients And Doctors", font22));
            pdfDocument.Add(prgHeading);

            //Filters
            Paragraph prgAuthor = new Paragraph();
            Font font1 = new Font(Font.FontFamily.TIMES_ROMAN, 11f, Font.NORMAL | Font.NORMAL, BaseColor.BLACK);
            
            prgAuthor.Alignment = Element.ALIGN_RIGHT;
            prgAuthor.Add(new Chunk("Reported by : Ragiri Rajasekhar\n", font1));
            prgAuthor.Add(new Chunk("Report Date : " + DateTime.Now.ToShortDateString(), font1));
            pdfDocument.Add(prgAuthor);

            //Add a line seperation
            Paragraph p = new Paragraph(new Chunk(new iTextSharp.text.pdf.draw.LineSeparator(0.0F, 100.0F, BaseColor.BLACK, Element.ALIGN_LEFT, 1)));
            pdfDocument.Add(p);

            //Add line break
            pdfDocument.Add(new Chunk("\n"));


            pdfDocument.Add(pdfTable);
            pdfDocument.Close();

            Response.ContentType = "application/pdf";
            Response.AppendHeader("content-disposition",
                "attachment;filename=DoctorsList.pdf");
            Response.Write(pdfDocument);
            Response.Flush();
            Response.End();
           
        }


        protected void ShowMessage(string Message, MessageType type)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), System.Guid.NewGuid().ToString(), "ShowMessage('" + Message + "','" + type + "');", true);
        }
        public override void VerifyRenderingInServerForm(Control control)
        {
        }
    }
}