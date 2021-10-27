﻿using System;
using System.Collections.Generic;

#nullable disable

namespace FYP1.dbModels
{
    public partial class TblFacultyCourseRegistration
    {
        public int FcrId { get; set; }
        public int? FacultyId { get; set; }
        public int? ClassId { get; set; }

        public virtual TblClass Class { get; set; }
        public virtual TblFaculty Faculty { get; set; }
    }
}