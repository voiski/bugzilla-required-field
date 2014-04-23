# -*- Mode: perl; indent-tabs-mode: nil -*-
#
# The contents of this file are subject to the Mozilla Public
# License Version 2.0 (the "License"); you may not use this file
# except in compliance with the License. You may obtain a copy of
# the License at http://www.mozilla.org/MPL/
#
# Software distributed under the License is distributed on an "AS
# IS" basis, WITHOUT WARRANTY OF ANY KIND, either express or
# implied. See the License for the specific language governing
# rights and limitations under the License.
#
# The Original Code is the RequiredField Extension.
#
# The Initial Developer of the Original Code is Alan Voiski
# Portions created by the Initial Developer are Copyright (C) 2014 the
# Initial Developer. All Rights Reserved.
#
# Contributor(s): 
#   Alan Voiski <alannunesv@gmail.com>

package Bugzilla::Extension::RequiredField;
use strict;
use base qw(Bugzilla::Extension);

use Bugzilla::Constants;
use Bugzilla::Field;
use Bugzilla::Error;

our $VERSION = '1.0';


sub bug_end_of_create_validators {
    my ($self, $args) = @_;
    
    my $bug_params = $args->{'params'};

    # if the description of field has * in the end, condition 
    # to field requerid, and the value is not defined, throw exception
    foreach my $field (Bugzilla->active_custom_fields) {
        if($field->description =~ /^.*\*$/ ){
            if(!defined $bug_params->{$field->name} 
            || $bug_params->{$field->name} eq '' 
            || $field->type == FIELD_TYPE_SINGLE_SELECT && $bug_params->{$field->name} eq '---') {
                my $field_description=$field->description;
                $field_description =~ s/ \*//;
                ThrowUserError("invalid_parameter",
                       { name   => $field_description,
                         err => "Value is requerid" });
            }
        }
    }
}

sub bug_end_of_update {
    my ($self, $args) = @_;
    my ($bug, $old_bug, $timestamp, $changes) = 
        @$args{qw(bug old_bug timestamp changes)};

    # if the description of field has * in the end, condition 
    # to field requerid, and the value is not defined, throw exception
    foreach my $field (Bugzilla->active_custom_fields) {
        if($field->description =~ /^.*\*$/){

            my $field_value=$bug->{$field->name};

            if(defined $changes->{$field->name}){
                $field_value=$changes->{$field->name}->[1];
            }

            if(!defined $field_value 
            || $field_value eq ''
            || $field->type == FIELD_TYPE_SINGLE_SELECT && $field_value eq '---') {
                my $field_description=$field->description;
                $field_description =~ s/ \*//;
                ThrowUserError("invalid_parameter",
                       { name   => $field_description,
                         err => "Value is requerid" });
            }
        }
    }
}

 __PACKAGE__->NAME;
