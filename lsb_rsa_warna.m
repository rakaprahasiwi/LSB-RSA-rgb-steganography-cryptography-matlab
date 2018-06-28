function varargout = lsb_rsa_warna(varargin)
% LSB_RSA_WARNA MATLAB code for lsb_rsa_warna.fig
%      LSB_RSA_WARNA, by itself, creates a new LSB_RSA_WARNA or raises the existing
%      singleton*.
%
%      H = LSB_RSA_WARNA returns the handle to a new LSB_RSA_WARNA or the handle to
%      the existing singleton*.
%
%      LSB_RSA_WARNA('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in LSB_RSA_WARNA.M with the given input arguments.
%
%      LSB_RSA_WARNA('Property','Value',...) creates a new LSB_RSA_WARNA or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before lsb_rsa_warna_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to lsb_rsa_warna_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help lsb_rsa_warna

% Last Modified by GUIDE v2.5 27-Jun-2018 17:38:59

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @lsb_rsa_warna_OpeningFcn, ...
                   'gui_OutputFcn',  @lsb_rsa_warna_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before lsb_rsa_warna is made visible.
function lsb_rsa_warna_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to lsb_rsa_warna (see VARARGIN)

% Choose default command line output for lsb_rsa_warna
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes lsb_rsa_warna wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = lsb_rsa_warna_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in btnPilihGambar.
function btnPilihGambar_Callback(hObject, eventdata, handles)
% hObject    handle to btnPilihGambar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[FileName,PathName]=uigetfile('*.bmp;*.jpg','Select Image file');
global fullpathname1
fullpathname1 = strcat(PathName,FileName); %Resmin ismini ve konumunu birleþtirdik.
set(handles.txtPilihGambar,'String',fullpathname1);
gmb_asli = imread(fullpathname1);
handles.gmb_asli=gmb_asli; % menyimpan nilai variabel
guidata(hObject,handles);% instruksi simpan object

axes(handles.axesGambarAsli); % memasukkan nilai variabel pada axis
imshow(gmb_asli); % menampilkan image hasil browse


% --- Executes on button press in btnPilihFilePesan.
function btnPilihFilePesan_Callback(hObject, eventdata, handles)
% hObject    handle to btnPilihFilePesan (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename2 pathname2]=uigetfile({'*.txt'},'File Selector'); %Dosya sisteminden .txt uzantýlý dosya seçilir.
global fullpathname2
fullpathname2 = strcat(pathname2,filename2); %Dosyanýn ismini ve konumunu birleþtirdik.
set(handles.txtPilihFilePesan,'String',fullpathname2); %Dosyanýn ismini ve konumunu textbox a yazdýrdýk.
pesan = fileread(fullpathname2); %Dosyayý Okuduk.
if length(pesan) > 200
    pesan=pesan(1:200);
end
set(handles.txtPesanAsli,'String',pesan); %Dosya içeriðini Textbox'a yazdýrdýk.


% --- Executes during object creation, after setting all properties.
function edtPilihGambar_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edtPilihGambar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in btnEktraksi.
function btnEktraksi_Callback(hObject, eventdata, handles)
% hObject    handle to btnEktraksi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
N = getappdata(0,'nInFunction');
priv_key = getappdata(0,'pkInFunction');
e = getappdata(0,'eInFunction');
pjg_bit_pesan = getappdata(0,'pjgInFunction');
hasil_gmb_stego = getappdata(0,'hslInFunction');

%ekstraksi LSB
[pesan_ektraksi]=ekstraksilsb(hasil_gmb_stego,pjg_bit_pesan);
set(handles.txtPesanEktraksi,'string',pesan_ektraksi);

%decrypt RSA
decr=decryptrsa(pesan_ektraksi,N,priv_key,e);
set(handles.txtPesanDekripsi,'string',decr);


% --- Executes on button press in btnPenyisipan.
function btnPenyisipan_Callback(hObject, eventdata, handles)
% hObject    handle to btnPenyisipan (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
pesan=get(handles.txtPesanAsli,'string');

%encrypt RSA
[chip,PK,N,e,enc]=encryptrsa(pesan);
set(handles.txtPesanEnkripsi,'string',enc);

%penyisipan LSB
gmb_asli=getimage(handles.axesGambarAsli);
[pjg_bit_pesan,hasil_gmb_stego]=lsbsisipcolor(enc,gmb_asli);

axes(handles.axesGambarStego);
imshow(hasil_gmb_stego);

%MSE PSNR
[MSE,PSNR]=msepsnr(gmb_asli,hasil_gmb_stego);
set(handles.txtMse,'string',MSE);
set(handles.txtPsnr,'string',PSNR);


% --- Executes on button press in btnReset.
function btnReset_Callback(hObject, eventdata, handles)
% hObject    handle to btnReset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.txtPilihGambar,'String','');
set(handles.txtPilihFilePesan,'String','');
set(handles.txtPesanAsli,'String','');
set(handles.txtPesanEnkripsi,'String','');
set(handles.txtPesanEktraksi,'String','');
set(handles.txtPesanDekripsi,'String','');
set(handles.txtMse,'String','');
set(handles.txtPsnr,'String','');
axes(handles.axesGambarAsli); cla;
axes(handles.axesGambarStego); cla;
