function varargout = TCGUI(varargin)
% TCGUI MATLAB code for TCGUI.fig
%      TCGUI, by itself, creates a new TCGUI or raises the existing
%      singleton*.
%
%      H = TCGUI returns the handle to a new TCGUI or the handle to
%      the existing singleton*.
%
%      TCGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TCGUI.M with the given input arguments.
%
%      TCGUI('Property','Value',...) creates a new TCGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before TCGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to TCGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help TCGUI

% Last Modified by GUIDE v2.5 16-Mar-2021 17:44:00

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @TCGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @TCGUI_OutputFcn, ...
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


% --- Executes just before TCGUI is made visible.
function TCGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to TCGUI (see VARARGIN)

% Choose default command line output for TCGUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes TCGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = TCGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in start.
function start_Callback(hObject, eventdata, handles)
% hObject    handle to start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

index = get(handles.frameSize,'Value');
items = get(handles.frameSize,'String');
Size = str2double(items{index}); % Frame size

RateIndex = get(handles.codRate,'Value');
numFrames = get(handles.numFrames,'String'); % Num. of frames to sim.

% name of .txt where interleaver indices are stored (Size x 1 matrix)
intN = get(handles.intName,'String'); 
punctN = get(handles.punctName,'String'); 
fileID = fopen(intN);

if fileID < 0 
   set(handles.editText,'string','Error when opening interleaver text file.');
else
    cellInter = textscan(fileID,'%d');
    indInter = cell2mat(cellInter);
    fclose(fileID);
    
    fileID = fopen(punctN);
    if fileID < 0 
       set(handles.editText,'string','Error when opening puncturing text file.');
    else
        cellPunct = textscan(fileID,'%d');
        punct = cell2mat(cellPunct)
        punct = num2str(punct)-'0';
        fclose(fileID);
    

        switch RateIndex
            case 1
                set(handles.editText,'string','Running');
                BER = TC_CCSDS_1_2( Size,numFrames,indInter,punct,handles.axes1 );
                save('BER','BER');
                set(handles.editText,'string','Done');
            case 2
                set(handles.editText,'string','Running');
                BER = TC_CCSDS_1_3( Size,numFrames,indInter,punct,handles.axes1 );
                save('BER','BER');
                set(handles.editText,'string','Done');
            case 3    
                set(handles.editText,'string','Running');
                BER = TC_CCSDS_1_4( Size,numFrames,indInter,punct,handles.axes1 );
                save('BER','BER');
                set(handles.editText,'string','Done');
            case 4
                set(handles.editText,'string','Running');
                BER = TC_CCSDS_1_6( Size,numFrames,indInter,punct,handles.axes1 );
                save('BER','BER');
                set(handles.editText,'string','Done');
        end
            
    end

end


% set(handles.editText,'string',intN);

function editText_Callback(hObject, eventdata, handles)
% hObject    handle to editText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editText as text
%        str2double(get(hObject,'String')) returns contents of editText as a double


% --- Executes during object creation, after setting all properties.
function editText_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in frameSize.
function frameSize_Callback(hObject, eventdata, handles)
% hObject    handle to frameSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns frameSize contents as cell array
%        contents{get(hObject,'Value')} returns selected item from frameSize


% --- Executes during object creation, after setting all properties.
function frameSize_CreateFcn(hObject, eventdata, handles)
% hObject    handle to frameSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in frameSize.
function popupmenu2_Callback(hObject, eventdata, handles)
% hObject    handle to frameSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns frameSize contents as cell array
%        contents{get(hObject,'Value')} returns selected item from frameSize


% --- Executes during object creation, after setting all properties.
function popupmenu2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to frameSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in codRate.
function codRate_Callback(hObject, eventdata, handles)
% hObject    handle to codRate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns codRate contents as cell array
%        contents{get(hObject,'Value')} returns selected item from codRate


% --- Executes during object creation, after setting all properties.
function codRate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to codRate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function numFrames_Callback(hObject, eventdata, handles)
% hObject    handle to numFrames (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of numFrames as text
%        str2double(get(hObject,'String')) returns contents of numFrames as a double


% --- Executes during object creation, after setting all properties.
function numFrames_CreateFcn(hObject, eventdata, handles)
% hObject    handle to numFrames (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function intName_Callback(hObject, eventdata, handles)
% hObject    handle to intName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of intName as text
%        str2double(get(hObject,'String')) returns contents of intName as a double


% --- Executes during object creation, after setting all properties.
function intName_CreateFcn(hObject, eventdata, handles)
% hObject    handle to intName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function punctName_Callback(hObject, eventdata, handles)
% hObject    handle to punctName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of punctName as text
%        str2double(get(hObject,'String')) returns contents of punctName as a double


% --- Executes during object creation, after setting all properties.
function punctName_CreateFcn(hObject, eventdata, handles)
% hObject    handle to punctName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
