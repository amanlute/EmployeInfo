using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Data.SqlClient;
using EmployeInfo.Models;
using System.Data;
using System.Collections;
using System.Data.Common;
using System.Drawing;
using System.Reflection.Emit;
using System.IO;

namespace EmployeInfo.Controllers
{
    public class EmpController : Controller
    {
        public string connectionString = ConfigurationManager.ConnectionStrings["mydb"].ToString();

        SqlConnection conn;      

        public ActionResult Index()
        {

            return View();

        }

        //Get Departments
        public JsonResult GetDepartments()
        {
            List<Departments> departments = new List<Departments>();
            conn = new SqlConnection(connectionString);
            conn.Open();

            SqlCommand cmd = new SqlCommand("sp_getData", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@Action", "Departmentget");

            SqlDataAdapter da = new SqlDataAdapter(cmd);           
            DataTable dt = new DataTable();
            da.Fill(dt);
            foreach (DataRow dr in dt.Rows)
            {
                departments.Add(new Departments
                {
                    ID = (int)dr["DeptID"],
                    DeptName = dr["DeptName"].ToString(),

                });
            }
            conn.Close();

            return Json(departments, JsonRequestBehavior.AllowGet);

        }

        //Get Designations
        public JsonResult GetDesignations()
        {
            List<Designations> designationList = new List<Designations>();
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("sp_getData", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@Action", "Designationget");

                SqlDataReader dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    designationList.Add(new Designations
                    {
                        ID = Convert.ToInt32(dr["id"]),
                        DesignationName = dr["designationName"].ToString()
                    });
                }
            }
            return Json(designationList, JsonRequestBehavior.AllowGet);
        }

        //Insert Employee
        public JsonResult InsertEmployee(Emp emp)
        {

          
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();             
                try
                {

                    SqlCommand cmd = new SqlCommand("Employeecrud", connection);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@EmpID", emp.EmpID);
                    cmd.Parameters.AddWithValue("@EmpCode", emp.EmpCode);
                    cmd.Parameters.AddWithValue("@EmpName", emp.EmpName);
                    cmd.Parameters.AddWithValue("@Gender", emp.Gender);
                    cmd.Parameters.AddWithValue("@Designation", emp.SelectedDesignation);
                    cmd.Parameters.AddWithValue("@Department", emp.Dept);
                    cmd.Parameters.AddWithValue("@Action", "INSERT");
                    cmd.Parameters.AddWithValue("@ImageURL", emp.ProfilePicture); // image URL

                  
                    cmd.ExecuteNonQuery();

                }
                catch (Exception ex)
                {
                    return Json(new { success = false }, JsonRequestBehavior.AllowGet);
                }

                return Json(new { success = true }, JsonRequestBehavior.AllowGet);

            }
        }

        public JsonResult UploadFile()
        {
            try
            {
                if (Request.Files.Count > 0)
                {
                    var file = Request.Files[0];
                    if (file != null && file.ContentLength > 0)
                    {
                        string fileName =Path.GetFileName(file.FileName);
                        string fileExtension=Path.GetExtension(file.FileName);
                        string timeStamp = DateTime.Now.ToString("yyyy_MM_dd_HHmmss");                      
                        string newFileName = $"{fileName}_{timeStamp}{fileExtension}";

                        string filePath = Path.Combine(Server.MapPath("~/Uploads/"), newFileName);
                        file.SaveAs(filePath);

                        return Json(new { success = true, filePath = "/Uploads/" + newFileName });
                    }
                }
                return Json(new { success = false, message = "No file uploaded" });
            }
            catch (Exception ex)
            {
                return Json(new { success = false, message = ex.Message });
            }
        }

        //Get Employee 
        public JsonResult getEmployees()
        {
            List<Emp> list = new List<Emp>();
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("sp_getData", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@Action", "Employeeget");

                SqlDataReader dr = cmd.ExecuteReader();

                while (dr.Read())
                {
                    try
                    {
                        list.Add(new Emp()
                        {
                            EmpID = Convert.ToInt32(dr["empId"]),
                            EmpCode = dr["empCode"].ToString(),
                            EmpName = dr["empName"].ToString(),                          
                            Dept = dr["department_name"].ToString(),
                            Gender = Convert.ToInt32(dr["gender"]),
                            Designations = dr["designationName"].ToString(),
                            IsActiveEmp = Convert.ToInt32(dr["isActiveEmp"])
                        });
                    }
                    catch (Exception e)
                    {

                    }
                }
            }
            return Json(list, JsonRequestBehavior.AllowGet);
        }

        //Edit Employee From Table        
        public JsonResult EditEmployee(int id)
        {
            Emp emp = null;

            string connString = ConfigurationManager.ConnectionStrings["mydb"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connString))
            {
                conn.Open();             
                using (SqlCommand cmd = new SqlCommand("sp_getData", conn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@EmpId", id);
                    cmd.Parameters.AddWithValue("@Action", "Edit");

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            emp = new Emp
                            {
                                EmpID = Convert.ToInt32(reader["empId"]),
                                EmpCode = reader["empCode"].ToString(),
                                EmpName = reader["empName"].ToString(),                                
                                Dept = reader["Department"].ToString(),
                                designationId = Convert.ToInt32(reader["designation"]),
                                Gender = Convert.ToInt32(reader["gender"]),
                              //  ProfilePicture = reader["ImageURL"].ToString()

                            };
                        }
                    }
                }
            }
            return Json(emp, JsonRequestBehavior.AllowGet);
        }

        public JsonResult DeleteEmp(int id)
        {
            Emp emp = new Emp();

            string connString = ConfigurationManager.ConnectionStrings["mydb"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connString))
            {
                conn.Open();
                using (SqlCommand cmd = new SqlCommand("sp_getData", conn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@EmpId", id);
                    cmd.Parameters.AddWithValue("@Action", "Delete");
                    cmd.ExecuteNonQuery();
                }
            }
            return Json(emp, JsonRequestBehavior.AllowGet);
        }

        public JsonResult MakeActive(int id)
        {
            Emp emp = new Emp();

            string connString = ConfigurationManager.ConnectionStrings["mydb"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connString))
            {
                conn.Open();
                using (SqlCommand cmd = new SqlCommand("sp_getData", conn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@EmpId", id);
                    cmd.Parameters.AddWithValue("@Action", "MakeActive");
                    cmd.ExecuteNonQuery();
                }
            }
            return Json(emp, JsonRequestBehavior.AllowGet);
        }

    public JsonResult ViewEmployee(int id)
        {
            Emp emp = null;

            string connString = ConfigurationManager.ConnectionStrings["mydb"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connString))
            {
                conn.Open();
                using (SqlCommand cmd = new SqlCommand("sp_getData", conn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@EmpId", id);
                    cmd.Parameters.AddWithValue("@Action", "Employee_View");

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            emp = new Emp
                            {
                                EmpID = Convert.ToInt32(reader["empId"]),
                                EmpCode = reader["empCode"].ToString(),
                                EmpName = reader["empName"].ToString(),
                                Dept = reader["department_name"].ToString(),
                                Designations = reader["designationName"].ToString(),
                                Gender = Convert.ToInt32(reader["gender"]),
                                ProfilePicture = reader["ImageURL"].ToString()

                            };
                        }
                    }
                }
            }
            return Json(emp, JsonRequestBehavior.AllowGet);
        }

    }


}