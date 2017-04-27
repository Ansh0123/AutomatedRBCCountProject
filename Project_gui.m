function varargout = Project_gui(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Project_gui_OpeningFcn, ...
                   'gui_OutputFcn',  @Project_gui_OutputFcn, ...
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


% --- Executes just before Project_gui is made visible.
function Project_gui_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Project_gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Project_gui_OutputFcn(hObject, eventdata, handles) 
clc;
varargout{1} = handles.output;


% --- Executes on button press in input_image.
function input_image_Callback(hObject, eventdata, handles)
[filename,path] = uigetfile({'*.jpeg';'*.jpg';'*.png';},'File Selector');
actual_path = strcat(path,filename);
I = imread(actual_path);
setappdata(0,'I_1',I);

% --- Executes on button press in ext_btn.
function ext_btn_Callback(hObject, eventdata, handles)
msgbox('Thanks For Using! Be sure to visit here again!');
pause(1);
close();
close();



% --- Executes on button press in orginal_image.
function orginal_image_Callback(hObject, eventdata, handles)
I = getappdata(0,'I_1');
axes(handles.axes1);
imshow(I)


% --- Executes on button press in gray_image.
function gray_image_Callback(hObject, eventdata, handles)
II = getappdata(0,'I_1');
gray_image = rgb2gray(II);
axes(handles.axes2);
imshow(gray_image)
setappdata(0,'Gray_1',gray_image);


% --- Executes on button press in canny.
function canny_Callback(hObject, eventdata, handles)
gray_image = getappdata(0,'Gray_1');
[~, threshold] = edge(gray_image, 'canny');
fudgeFactor = 1.5;
canny_edge = edge(gray_image,'canny', threshold * fudgeFactor);
axes(handles.axes3);
imshow(canny_edge)
setappdata(0,'canny_1',canny_edge);



% --- Executes on button press in noise.
function noise_Callback(hObject, eventdata, handles)
canny_edge = getappdata(0,'canny_1');
se90 = strel('line', 1, 90);
se0 = strel('line', 1, 0);
bb = imdilate(canny_edge, [se90 se0]);
 noise_reduction= imclearborder(bb);
 axes(handles.axes4);
 imshow(noise_reduction);
 setappdata(0,'canny_edge1',canny_edge);



% --- Executes on button press in circles.
function circles_Callback(hObject, eventdata, handles)
BWsdil = getappdata(0,'canny_edge1');
BWdfill = imfill(BWsdil, 'holes');
% figure, imshow(BWdfill),title('binary image with filled holes');
%states = regionprops(BWdfill)
% bw = im2bw(BWdfill);
 BW2 = bwpropfilt(BWdfill,'area',[383 750]);
cc = bwconncomp(BW2, 4);
cc1 = cc.NumObjects;
setappdata(0,'circularcell',cc1);
ccstring = num2str(cc1);
set(handles.set1,'string',ccstring);
 axes(handles.axes5);
imshow(BW2)
setappdata(0,'area_circle1',BW2);


% --- Executes on button press in overlapped.
function overlapped_Callback(hObject, eventdata, handles)
BWs = getappdata(0,'canny_edge1');
BW_out = BWs;
BW_out = imclearborder(BW_out);
BW_out = imfill(BW_out, 'holes');
BW_out = bwpropfilt(BW_out, 'MajorAxisLength', [30, 90]);
BW_out = bwpropfilt(BW_out, 'MinorAxisLength', [0, 30]);
BW_out = bwpropfilt(BW_out, 'Eccentricity', [0.795, 0.907]);
BW_out = bwpropfilt(BW_out, 'Area', [300, 2700]);
cc = bwconncomp(BW_out, 4);
cc1 = cc.NumObjects;
ccstring = num2str(cc1);
set(handles.set2,'string',ccstring);
tmp = getappdata(0,'circularcell');
totalCells = tmp+ cc1*2;
set(handles.set3,'string',num2str(totalCells));
axes(handles.axes6);
imshow(BW_out);
setappdata(0,'overLapped1',BW_out);



function set1_Callback(hObject, eventdata, handles)
% hObject    handle to set1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of set1 as text
%        str2double(get(hObject,'String')) returns contents of set1 as a double


% --- Executes during object creation, after setting all properties.
function set1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to set1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function set2_Callback(hObject, eventdata, handles)
% hObject    handle to set2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of set2 as text
%        str2double(get(hObject,'String')) returns contents of set2 as a double


% --- Executes during object creation, after setting all properties.
function set2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to set2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function set3_Callback(hObject, eventdata, handles)
% hObject    handle to set3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of set3 as text
%        str2double(get(hObject,'String')) returns contents of set3 as a double


% --- Executes during object creation, after setting all properties.
function set3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to set3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
