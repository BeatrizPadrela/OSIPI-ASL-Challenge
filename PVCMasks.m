
% ### CBF in GM and WM wiht and without PVC ### %
%
% Here we use PVGM/PVWM as a mask. And overlap with either CBF.nii or with CBFGM/WM.nii
%
%    These will give mean CBF in GM and WM (with and without PVC)
%
% Thresholds used:
%  GM: 0.7 non-PVC, 0.5 PVC
%  WM: 0.9 non-PVC, 0.7 PVC
%
%

%Dir = '/home/bestevespadrela/lood_storage/divi/Projects/ExploreASL/OSIPI_Challenge_Data/Population_based/derivatives/ExploreASL/'; % derivatives/ExploreASL directory
Dir = '/home/bestevespadrela/lood_storage/divi/Projects/ExploreASL/OSIPI_Challenge_Data/synthetic/derivatives/ExploreASL/';

SubList = xASL_adm_GetFileList(Dir, '^sub-', 'FPList',[0 Inf], true);

for iS = 1:length(SubList)
    
[~, SubjName] = fileparts(SubList{iS});

    % #### GM ####
PVGM = xASL_io_Nifti2Im(fullfile(SubList{iS},'ASL_1', 'PVgm.nii.gz')); % when subjects have only 1 session (ASL_1)
    % PVGM over CBF.nii
PVGM_mask = PVGM(:,:,:)>0.7;
CBF = xASL_io_Nifti2Im(fullfile(SubList{iS},'ASL_1', 'CBF.nii.gz')); 
CBF_GMmasked = OverlappingMask(CBF,PVGM_mask);
CBF_GMmasked_mean = mean(isnan(nonzeros(CBF_GMmasked(:))));
CBF_GMmasked_SD = std(nonzeros(CBF_GMmasked(:)));

    % PVGM over CBFGM.nii (PVC CBF)
PVGM_mask_PVC = PVGM(:,:,:)>0.5;
CBFPVC_GM = xASL_io_Nifti2Im(fullfile(SubList{iS},'ASL_1', 'CBFgm.nii.gz')); 
CBFPVC_GMmasked = OverlappingMask(CBFPVC_GM,PVGM_mask_PVC);
CBFPVC_GMmasked_mean = mean(nonzeros(CBFPVC_GMmasked(:)));
CBFPVC_GMmasked_SD = std(nonzeros(CBFPVC_GMmasked(:)));


    % #### WM ####
PVWM = xASL_io_Nifti2Im(fullfile(SubList{iS},'ASL_1', 'PVwm.nii.gz')); % when subjects have only 1 session (ASL_1)
    % WM over CBF.nii
PVWM_mask = PVWM(:,:,:)>0.9;
CBF = xASL_io_Nifti2Im(fullfile(SubList{iS},'ASL_1', 'CBF.nii.gz')); 
CBF_WMmasked = OverlappingMask(CBF,PVWM_mask);
CBF_WMmasked_mean = mean(nonzeros(CBF_WMmasked(:)));
CBF_WMmasked_SD = std(nonzeros(CBF_WMmasked(:)));

    % PVWM over CBFWM.nii (PVC CBF)
PVWM_mask_PVC = PVWM(:,:,:)>0.7;
CBFPVC_WM = xASL_io_Nifti2Im(fullfile(SubList{iS},'ASL_1', 'CBFwm.nii.gz')); 
CBFPVC_WMmasked = OverlappingMask(CBFPVC_WM,PVWM_mask_PVC);
CBFPVC_WMmasked_mean = mean(nonzeros(CBFPVC_WMmasked(:)));
CBFPVC_WMmasked_SD = std(nonzeros(CBFPVC_WMmasked(:)));


CBFvalues{1,1}='Subject';
CBFvalues{1,2}='CBF PVGMmasked mean';
CBFvalues{1,3}='CBF PVGMmasked SD';
CBFvalues{1,4}='CBFPVC PVGMmasked mean';
CBFvalues{1,5}='CBFPVC PVGMmasked SD';
CBFvalues{1,6}='CBF PVWMmasked mean';
CBFvalues{1,7}='CBF PVWMmasked SD';
CBFvalues{1,8}='CBFPVC PVWMmasked mean';
CBFvalues{1,9}='CBFPVC PVWMmasked SD';

CBFvalues{iS+1,1}= SubjName;
CBFvalues{iS+1,2}= CBF_GMmasked_mean;
CBFvalues{iS+1,3}= CBF_GMmasked_SD;
CBFvalues{iS+1,4}= CBFPVC_GMmasked_mean;
CBFvalues{iS+1,5}= CBFPVC_GMmasked_SD;
CBFvalues{iS+1,6}= CBF_WMmasked_mean;
CBFvalues{iS+1,7}= CBF_WMmasked_SD;
CBFvalues{iS+1,8}= CBFPVC_WMmasked_mean;
CBFvalues{iS+1,9}= CBFPVC_WMmasked_SD;

end
