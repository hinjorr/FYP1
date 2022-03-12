using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using FYP1.DTOs;

namespace FYP1.Repository
{
    public interface IClassContent
    {
        Task<GeneralDTO> AddUrl(UrlDTO dto);
        Task<List<UrlDTO>> GetUrls(int _sessionId, int _classId);
        void DeleteUrl(int _id);
        Task<UrlDTO> GetSingleUrl(int _id);
        Task<GeneralDTO> UploadAssesment(AssesmentDTO dto);
        Task<List<AssesmentDTO>> GetAssesment(int _sessionId, int _classId);
        void DeleteAssesment(int _id);
        Task<GeneralDTO> GetAssesmentDetail(int id);
        Task<List<GeneralDTO>> AssesmentStudents(int class_id, int assesment_id);
        Task<GeneralDTO> AssesmentSubmission(AssesmentSubmissionDTO dto);
        Task<GeneralDTO> GetSingleAssesment(int assesment_id);
        Task<bool> DeleteAssesmentAttachment(int fileId);
        Task<GeneralDTO> UploadVideos(VideosDTO _videos);
        Task<List<VideosDTO>> GetVideos(int sessionId, int classId);
        Task<bool> DeleteVideo(int _videoId);
        Task<GeneralDTO> UploadDocs(DocDTO dto);
        Task<List<DocDTO>> GetDocFiles(int class_id, int sessionId);
        Task<bool> DeleteDocFile(int doc_id);
    }
}