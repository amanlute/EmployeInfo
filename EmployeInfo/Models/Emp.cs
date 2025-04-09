using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace EmployeInfo.Models
{
	public class Emp
	{
		public int EmpID { get; set; }
		public string EmpCode { get; set; }
		public string EmpName { get; set; }
		public int Gender { get; set; }

        public string Dept { get; set; }
		public string Designations { get; set; }

		public int designationId { get; set; }

		public int SelectedDesignation { get; set; }

        public string ProfilePicture { get; set; }

		public int IsActiveEmp { get; set; }
    }

	public class Departments
	{
		public int ID { get; set; }
		public string DeptName { get; set; }

	}

	public class Designations
	{
		public int ID { get; set; }
		public string DesignationName{get; set;}
	}
}