/*
 *  Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
 *
 *  Licensed under the Apache License, Version 2.0 (the "License").
 *  You may not use this file except in compliance with the License.
 *  A copy of the License is located at
 *
 *  http://aws.amazon.com/apache2.0
 *
 *  or in the "license" file accompanying this file. This file is distributed
 *  on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
 *  express or implied. See the License for the specific language governing
 *  permissions and limitations under the License.
 */

const _ = require('lodash');

class CfnTemplate {
  constructor({ accountId, region }) {
    this.accountId = accountId;
    // Internal data structures
    this.resources = {};
    this.outputs = {};

    // Description limit is 1k
    this.description = [
      'This template is generated by the Service Workbench application to allow it to connect ',
      `to studies owned by account "${accountId}".`,
      `IMPORTANT: ensure that you deploy this template in account "${accountId}" and region "${region}"`,
    ].join('');
  }

  addResources(resources = []) {
    _.forEach(resources, resource => {
      this.addResource(resource);
    });
  }

  /**
   * @param resource a resource object with the following shape { 'logicalId': <logicalId>, 'resource': <resource> }
   */
  addResource(resource) {
    this.resources[resource.logicalId] = resource.resource;
  }

  addOutput(key, value) {
    this.outputs[key] = {
      Value: value,
    };
  }

  toJson() {
    return {
      AWSTemplateFormatVersion: '2010-09-09',
      Description: this.description,
      Resources: this.resources,
      Outputs: this.outputs,
    };
  }
}

module.exports = { CfnTemplate };
