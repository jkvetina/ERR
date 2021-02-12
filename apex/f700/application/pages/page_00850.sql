prompt --application/pages/page_00850
begin
--   Manifest
--     PAGE: 00850
--   Manifest End
wwv_flow_api.component_begin (
 p_version_yyyy_mm_dd=>'2020.10.01'
,p_release=>'20.2.0.00.20'
,p_default_workspace_id=>9526531750928358
,p_default_application_id=>700
,p_default_id_offset=>28323188538908472
,p_default_owner=>'DEV'
);
wwv_flow_api.create_page(
 p_id=>850
,p_user_interface_id=>wwv_flow_api.id(63766922917014449)
,p_name=>'#fa-file-excel-o'
,p_alias=>'UPLOADER'
,p_step_title=>'Uploader'
,p_autocomplete_on_off=>'OFF'
,p_group_id=>wwv_flow_api.id(10819719419852508)
,p_step_template=>wwv_flow_api.id(64127379571157916)
,p_page_template_options=>'#DEFAULT#'
,p_required_role=>'MUST_NOT_BE_PUBLIC_USER'
,p_last_updated_by=>'DEV'
,p_last_upd_yyyymmddhh24miss=>'20210211232855'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(10827906605034122)
,p_plug_name=>'Upload File'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(64142195941700285)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(10828139447034124)
,p_plug_name=>'Recent Files'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(64142195941700285)
,p_plug_display_sequence=>20
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(10828249077034125)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(10827906605034122)
,p_button_name=>'CLEAR_FILTERS'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(63744470351014400)
,p_button_image_alt=>'&CLEAR_FILTERS.'
,p_button_position=>'RIGHT_OF_TITLE'
,p_button_redirect_url=>'f?p=&APP_ID.:850:&SESSION.::&DEBUG.::P850_RESET:Y'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(10830426198034147)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(10827906605034122)
,p_button_name=>'SUBMIT'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(63744470351014400)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Submit'
,p_button_position=>'RIGHT_OF_TITLE'
,p_button_execute_validations=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(10828011451034123)
,p_name=>'P850_FILE'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(10827906605034122)
,p_prompt=>'File'
,p_display_as=>'NATIVE_FILE'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(63743308864014396)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'APEX_APPLICATION_TEMP_FILES'
,p_attribute_09=>'REQUEST'
,p_attribute_10=>'Y'
,p_attribute_12=>'DROPZONE_BLOCK'
,p_attribute_13=>'Drop Your Files'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(10828321706034126)
,p_name=>'P850_RESET'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(10827906605034122)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(10828486408034127)
,p_name=>'P850_TARGET'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(10827906605034122)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(10830531543034148)
,p_name=>'P850_SESSION'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(10827906605034122)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(10830608056034149)
,p_process_sequence=>10
,p_process_point=>'AFTER_HEADER'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'SET_SESSION'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'apex.set_item(''$SESSION'', sess.get_session_id());',
''))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(10830355098034146)
,p_process_sequence=>10
,p_process_point=>'ON_SUBMIT_BEFORE_COMPUTATION'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'UPLOAD_FILES'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'-- somehow session_id get lost/changed during submit',
'-- so we pass it via argument',
'uploader.upload_files (',
'    in_session_id => apex.get_item(''$SESSION'')',
');',
'--',
'apex.clear_items();',
'apex.redirect(851);',
''))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.component_end;
end;
/