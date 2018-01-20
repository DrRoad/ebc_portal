<template>
    <div>
        <el-button type="text" @click="visible = true">register</el-button>
        <el-dialog title="Acceptance of Terms" :visible.sync="visible">
            <el-form :model="form" ref="registerForm">
                <el-form-item
                    prop="email"
                    label="Email"
                    :label-width="formLabelWidth"
                    :rules="[
                        { required: true, message: 'Please input email address', trigger: 'blur' },
                        { type: 'email', message: 'Please input correct email address', trigger: 'blur,change' }
                    ]"
                    ref="emailItem"
                >
                    <el-input v-model="form.email" auto-complete="off" @change="checkEmail()"></el-input>
                </el-form-item>
                <el-form-item label="Name" :label-width="formLabelWidth">
                    <el-input v-model="form.name" auto-complete="off"></el-input>
                </el-form-item>
                <el-form-item label="Organization" :label-width="formLabelWidth">
                    <el-input v-model="form.organization" auto-complete="off"></el-input>
                </el-form-item>
                <el-checkbox v-model="form.checked">
                    I agree to appropriately cite the source of the data being downloaded if it will be used in any publications.
                </el-checkbox>
            </el-form>
            <span slot="footer" class="dialog-footer">
                <el-button @click="visible = false">Cancel</el-button>
                <el-button type="primary" @click="submit('registerForm')" :disabled="!validForm">Confirm</el-button>
            </span>
        </el-dialog>
    </div>
</template>

<script>
    import axios from 'axios'
    import {Dialog, Form, FormItem, Input, Button, Checkbox} from 'element-ui'

    axios.defaults.crossDomain = true

    export default {
        components: {
            'el-dialog': Dialog,
            'el-form': Form,
            'el-form-item': FormItem,
            'el-input': Input,
            'el-button': Button,
            'el-checkbox': Checkbox
        },
        data: function() {
            return {
                visible: false,
                registered: false,
                validEmail: false,
                form: {
                    email: '',
                    name: '',
                    organization: '',
                    checked: false,
                },
                formLabelWidth: '120px'
            }
        },
        computed: {
            validForm: function() {
                return this.form.checked && this.validEmail
            }
        },
        methods: {
            checkEmail: function() {
                if(this.$refs.emailItem) {
                    this.validEmail = (this.$refs.emailItem.validateState === "success")
                } else {
                    this.validEmail = false
                }
            },
            submit: function(formName) {
                var thiz = this
                if (thiz.validForm) {
                    thiz.visible = false
                    axios.post(
                        'https://b3mhxedpr3.execute-api.us-east-2.amazonaws.com/dev/register', 
                        {
                            email: thiz.form.email,
                            name: thiz.form.name,
                            organization: thiz.form.organization
                        }
                    )
                    .then(function (response) {
                        thiz.registered = true;
                        console.log(response)

                    })
                    .catch(function (error) {
                        console.log(error);
                    });
                } else {
                    console.log('error submit!!');
                    return false;
                }
            }
        }
    }
</script>