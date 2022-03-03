using System.Runtime.InteropServices;
using System.ComponentModel;
using System.Collections.Generic;
using System.Threading.Tasks;
using FYP1.DTOs;
using FYP1.Repository;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using FYP1.Helpers__Filters;

namespace FYP1.Controllers
{
    public class ClassContentController : Controller
    {
        private readonly IClassContent repo;

        public ClassContentController(IClassContent _repo)
        {
            repo = _repo;
        }
        public async Task<IActionResult> AddUrl(UrlDTO dto)
        {
            var data = await repo.AddUrl(dto);
            return Ok(data);
        }
        public async Task<IActionResult> GetUrls(int sessionId, int classId)
        {
            var data = await repo.GetUrls(sessionId, classId);
            return Ok(data);
        }
        public async Task<IActionResult> GetSingleUrl(int id)
        {
            var data = await repo.GetSingleUrl(id);
            return Ok(data);
        }

        public IActionResult DeleteUrl(int id)
        {
            repo.DeleteUrl(id);
            return Ok();
        }

        [HttpPost]
        public async Task<IActionResult> UploadAssesment([FromForm] AssesmentDTO dto)
        {
            var data = await repo.UploadAssesment(dto);
            return Ok(data);
        }
        public async Task<IActionResult> GetAssesment(int _sessionId, int _classId)
        {
            var data = await repo.GetAssesment(_sessionId, _classId);
            return Ok(data);
        }
        public IActionResult DeleteAssesment(int id)
        {
            repo.DeleteAssesment(id);
            return Ok();
        }

        [AuthenticateFilter]
        [HttpGet("ViewAssesment/{classid}/{assesmentid}")]
        public IActionResult ViewAssesment(int id)
        {
            return View();
        }
        public async Task<IActionResult> GetAssesmentDetail(int id)
        {
            var data = await repo.GetAssesmentDetail(id);
            return Ok(data);
        }
        public async Task<IActionResult> AssesmentStudents(int class_id, int assesment_id)
        {
            var _data = await repo.AssesmentStudents(class_id, assesment_id);
            return Json(new { data = _data });
        }

        [HttpPost]
        public async Task<IActionResult> AssesmentSubmission([FromForm] AssesmentSubmissionDTO dto)
        {
            var data = await repo.AssesmentSubmission(dto);
            return Ok(data);
        }
        public async Task<IActionResult> GetSingleAssesment(int assesment_id)
        {
            var data = await repo.GetSingleAssesment(assesment_id);
            return Ok(data);
        }
        public async Task<IActionResult> DeleteAssesmentAttachment(int fileId)
        {
            var data = await repo.DeleteAssesmentAttachment(fileId);
            return Ok();
        }
        public async Task<IActionResult> GetVideos(int sessionId, int classId)
        {
            var data = await repo.GetVideos(sessionId, classId);
            return Ok(data);
        }
        [HttpPost]
        public async Task<IActionResult> UploadVideos([FromForm] VideosDTO videos)
        {
            var data = await repo.UploadVideos(videos);
            return Ok(data);
        }
        // public async Task<IActionResult> DeleteFile(int fileId)
        // {
        //     var data = await repo.DeleteFile(fileId);
        //     return Ok(data);
        // }
    }
}
