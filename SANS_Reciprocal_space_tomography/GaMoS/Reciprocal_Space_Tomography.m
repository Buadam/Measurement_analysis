function varargout = Reciprocal_Space_Tomography(varargin)
% RECIPROCAL_SPACE_TOMOGRAPHY MATLAB code for Reciprocal_Space_Tomography.fig
%      RECIPROCAL_SPACE_TOMOGRAPHY, by itself, creates a new RECIPROCAL_SPACE_TOMOGRAPHY or raises the existing
%      singleton*.
%
%      H = RECIPROCAL_SPACE_TOMOGRAPHY returns the handle to a new RECIPROCAL_SPACE_TOMOGRAPHY or the handle to
%      the existing singleton*.
%
%      RECIPROCAL_SPACE_TOMOGRAPHY('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in RECIPROCAL_SPACE_TOMOGRAPHY.M with the given input arguments.
%
%      RECIPROCAL_SPACE_TOMOGRAPHY('Property','Value',...) creates a new RECIPROCAL_SPACE_TOMOGRAPHY or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Reciprocal_Space_Tomography_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Reciprocal_Space_Tomography_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Reciprocal_Space_Tomography

% Last Modified by GUIDE v2.5 28-Aug-2017 10:56:01

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Reciprocal_Space_Tomography_OpeningFcn, ...
                   'gui_OutputFcn',  @Reciprocal_Space_Tomography_OutputFcn, ...
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


% --- Executes just before Reciprocal_Space_Tomography is made visible.
function Reciprocal_Space_Tomography_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Reciprocal_Space_Tomography (see VARARGIN)

% Choose default command line output for Reciprocal_Space_Tomography
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Reciprocal_Space_Tomography wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Reciprocal_Space_Tomography_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on slider movement.
function min_value_sl_Callback(hObject, eventdata, handles)
% hObject    handle to min_value_sl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function min_value_sl_CreateFcn(hObject, eventdata, handles)
% hObject    handle to min_value_sl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function max_value_sl_Callback(hObject, eventdata, handles)
% hObject    handle to max_value_sl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function max_value_sl_CreateFcn(hObject, eventdata, handles)
% hObject    handle to max_value_sl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function min_value_Callback(hObject, eventdata, handles)
% hObject    handle to min_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of min_value as text
%        str2double(get(hObject,'String')) returns contents of min_value as a double


% --- Executes during object creation, after setting all properties.
function min_value_CreateFcn(hObject, eventdata, handles)
% hObject    handle to min_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function max_value_Callback(hObject, eventdata, handles)
% hObject    handle to max_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of max_value as text
%        str2double(get(hObject,'String')) returns contents of max_value as a double


% --- Executes during object creation, after setting all properties.
function max_value_CreateFcn(hObject, eventdata, handles)
% hObject    handle to max_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function height_sl_Callback(hObject, eventdata, handles)
% hObject    handle to height_sl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function height_sl_CreateFcn(hObject, eventdata, handles)
% hObject    handle to height_sl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function height_Callback(hObject, eventdata, handles)
% hObject    handle to height (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of height as text
%        str2double(get(hObject,'String')) returns contents of height as a double


% --- Executes during object creation, after setting all properties.
function height_CreateFcn(hObject, eventdata, handles)
% hObject    handle to height (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function slice_plane_1_Callback(hObject, eventdata, handles)
% hObject    handle to slice_plane_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of slice_plane_1 as text
%        str2double(get(hObject,'String')) returns contents of slice_plane_1 as a double


% --- Executes during object creation, after setting all properties.
function slice_plane_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slice_plane_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function slice_plane_2_Callback(hObject, eventdata, handles)
% hObject    handle to slice_plane_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of slice_plane_2 as text
%        str2double(get(hObject,'String')) returns contents of slice_plane_2 as a double


% --- Executes during object creation, after setting all properties.
function slice_plane_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slice_plane_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function slice_plane3_Callback(hObject, eventdata, handles)
% hObject    handle to slice_plane3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of slice_plane3 as text
%        str2double(get(hObject,'String')) returns contents of slice_plane3 as a double


% --- Executes during object creation, after setting all properties.
function slice_plane3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slice_plane3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
