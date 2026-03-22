Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011041.outbound.protection.outlook.com [40.107.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E282B1D8E01
	for <sched-ext@lists.linux.dev>; Sun, 22 Mar 2026 06:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774161356; cv=fail; b=G1a0li00BKzoaunoJd4lkEwQPEqbBp/XfqeONuva6ibroPneflTk48zhd0aR3YB3U7bFOxq+IgwbCgoUGoHmLZI0WHMabzZBkQlMBxPzQfIIhMaP1o5oBYP9uAjMP3Npt7HZtksTKkBvfn8Q5GkIVyHBc7UJWQAZUXP+MbSWw7U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774161356; c=relaxed/simple;
	bh=FPoqfVhbeiLr4iBCt9x9I0sDY5uJ1MZwhjDlBNW5MU8=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=qrSRdOHW5aADCLkqu7Bxu6DjBte6a8MuOyS1GUeR+1dIVkv625EdCvfYCH8Rfa5b8vxxC0n9Au7a3y37QsIYEBO1VbonYlHyrzQeXrXNgIi7pJt/rG6LySztH5DPEqj3IaK5WXDYwWy9h0EBdwzJTM1EllPpv0JKW0PKyddTX7Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eD88heP+; arc=fail smtp.client-ip=40.107.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eD88heP+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ImmYLAPdvkVY24hR51d3iJPO7Ur/a2Z+5wNKBClgbGmLZbT4yjMgKGIOYH1dkc1W5fP4WgQVwlAXF//cWfOPnJq44Zv0YFGBlyddTe7MpOzKaXygbsxceDbgKJh7rtHm4g1BdtcVuHMM9zLA8MSNHtGxVWhgTuSlrdQ8ruCxTJhsEutKiffeBmUztUfnUF49O3E+ub6rtIIGNp+CyCC0hOkJIftLWXJMoCJTjXUbTxWEDPa0ykHD6UsBBsSfk325cQGHXlXxHCDqUdUWfhVEBDrKOK6JyyBNOWxTpPRIlQzi7Y/1l3tl9c1kog4cgihy5YHkRwIdCHbtdcFk+Mh93Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eE1RqBu0Y7Vi8MHxaO2fhMsVF3ZqJpcXUvsXmN7PQVA=;
 b=g+2id6ezPSlXhdIqKT8vpvruPO9t2wu9SN8nQ2KSDPUOVv7CIEBJmhBh4XL4qr+rqJhUvXnsRSbBZNWV/Tdyzo/1OMHD8f6Ie7EKUA7gnUrPV1qmZ10ZsXq1VF0ymh4LrsKvl43AZdBhcwAPtcYtbvk5CiqVlDFJ9t/DjVEQDGDXiUyZDqQHAUaCBJJetkSWvXNRgcwEoAnafcg7IsF884Oe/vLiPbBoaLGQiS45TuA9jsd05CPkvXPwTXQTsxA3pWAOtslIr8E73ZK5VlSU1OHu+XcES4gUIO4hpOU7z5AcwPIHcTJ4PKsM8wjvCjgcJRzfaY8gvhc8yx2a6/l7FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eE1RqBu0Y7Vi8MHxaO2fhMsVF3ZqJpcXUvsXmN7PQVA=;
 b=eD88heP+rLJUS82Rypj9r53EKXcxn+gi7sPlXtVUvQ+4nK99GDXVga2e//WWznYltDYGKejxxqsxFoJoqiQNZAhxh+wZNTX2KlkfUeI4QOZqrlmZoMM5AF/qEwM2n2klvRcoIF71NmnC4rinrbPyR9aZd32jfmApUgP0ZCb3sdm8Y8DdfZONwbM9I46L+trSUAKWUy1KSlROiPhcvzuGtE6F8qgODieAo+fPyYria0v3A3n2MWCQu8h58f7IcCD2O3zv/sZf+4PdhYh2opf7ulQtyc7tx8izolnxOeQLoLdnuNh/qco9gT4c1qcJouxFq0uoBxHVNajBd5f0QAxM5w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.10; Sun, 22 Mar
 2026 06:35:50 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9745.012; Sun, 22 Mar 2026
 06:35:50 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Cheng-Yang Chou <yphbchou0911@gmail.com>
Subject: [PATCH v2 sched_ext/for-7.1] tools/sched_ext: Add compat handling for sub-scheduler ops
Date: Sun, 22 Mar 2026 07:35:46 +0100
Message-ID: <20260322063546.304416-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI0P293CA0006.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::17) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|LV3PR12MB9404:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d9bacb3-cbaa-4f2d-9332-08de87dd426c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	53W5KJ2Q9gQ2DRj9XlY/rLyjWJvl+458ZrwCcIBMeP1YjRdBJ0wz3dbl41tLp4TzpB87u6a/ieu+3JGztToC6jSyCkil1FI9b//zR8lsVldanVG3XINDOL/OeW/B7cmXIzRZy5oVxQcXL/OmWRDp2LwlKdpc7VgxWV7tIw3thIbHQYVODod1FjTwfytZm5rx3FCW+t0TuMOVRxXq//xPfncpdCNZMq8uX7MCUIjIBPSigaibAXDSLBu0nhJ7MRxYZ1xK3ydO88GzeZFB5MYHDMhbiJL0veALPyQ8HVLGXZaj/YbhTmKVCnvs+mcaATDyUh+Qr78LcrUv2QpSEpGGExht4IUVdObJZR6ZE1GICjEgcL+j2dw0smeGg31I/Ojm/SZTG59IQIV660M4HWPrYgeoORmqsxaYP7k0R8reYui6lRJYNSaUij014a+SBk2CxPEIhoIlJgl90t25sFUSHtd3h9pRnqCDCarqhIbqpTl8ILflvBC7TBulHBv2NG1IAujJpsbjcjcpYLBWhg1ks+VpaVcgN1+4dSRAEBVjNdQMsQjwfJBuQ0mnH0WP4TpbF0d0fhIQHNjYGmwkXbrQh0iPr9F54V7ut6/5/oQAwJpwWWjwoqJp6/RuZ1UW5VRztv2u4aRNRyS5LL246Q3ipdJfmxbOXn8uG7rfNjmI0BsyqmcJjfGsIaiUKtqnW3/cJGwwDnyo0Sq1ESOyS1mCKbn/noI+vKk97q7FOWSLXosTy8Z2ftOQgvfkikVo0bFD
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gMsUY3wh97AhpklvyT3khpdYpXIC8kBHjr3HLRnMwo1tlD8GKfHQWG2UTLyv?=
 =?us-ascii?Q?noBk7nhFEBP+Ysj1O8r9L3vpi5TihYVn2vbKDsntJsgGPxirQUGVKllBo1t4?=
 =?us-ascii?Q?ERyfKl+pXl4YfK4NgegZCIgBXDZp2cp417VGqjE3DYTJ+kdLkHpdBevckVnf?=
 =?us-ascii?Q?jFkQyKW7wu1af4bjBTOH+5QSerq39LFsXp3ocdXTNUdNpZsX3zbj3LtOUJL2?=
 =?us-ascii?Q?uNB+7jsof5mWvT9/KNtPAc2h5rtESwptrcAaK9ilYWx8R7vZhGy3qm4zQor7?=
 =?us-ascii?Q?oDWfGu6p5oOuDGqt02Adr3KTpmk9pcgtB3xDL8Lclv618kdWsvvU8SJUE8xu?=
 =?us-ascii?Q?9/h5wR0GQiuazBoWkCnKJa+BLBztp+hRxBPt13/synKzPzYHEsIU0wIHRh1O?=
 =?us-ascii?Q?VFP3qYu4lhfk0gnz2yn/Sk6KtdPwQluF+c1SW4YRhM1OrwNiDv+oJoeCWXev?=
 =?us-ascii?Q?+z0/6ybpNhgOg1LAP9AJFAKQo4VEEU7leEO7bItvx40Uh1lqJwBSwDowawYX?=
 =?us-ascii?Q?CIh4DXAX1CL1PZulMudit1HKdx+yWpTiYGD+lQ2G3F/pM8axc0zXb7wtCy/G?=
 =?us-ascii?Q?aS9x9WZvuJSLEDi9k5JzKBynkcIOqojU0HAL/Q7Ap/fNxi/xXvwwDqZ3MTbj?=
 =?us-ascii?Q?oSSCZFsmyPbHbDipty/mxv0ocFjy2GoF8EFmQoLqni+bd4iQQ5O8FdG4uWRD?=
 =?us-ascii?Q?tsTgDM+GYjrXHVO8yeFIEffcZTB/RH2SGr5EDvitYW9NcTy37okjMPI/tjFh?=
 =?us-ascii?Q?nXEZbIPlvf2zzxBIsuHPtQGsycKKhnt/ErTCJUYop45zCpxk4Fm7L+wam/zC?=
 =?us-ascii?Q?Hqsrp2W44/y8czHH2wMLucUs4Muj17vbBD/YDJenHIYvFDNuAUAhuYz1RC0Y?=
 =?us-ascii?Q?B973SOq/VxKO1wYjW8oQvQheHpxlCDmgDjCS/KqeI281gFrtMA4kQod8IL+f?=
 =?us-ascii?Q?JrRcx36Vp6XSf5zrkAtmzuyzSB924Uqyy9zu9mGCtKgr85z72hlD2UG+yPW4?=
 =?us-ascii?Q?dnggB9f4mLol2POWH5WxHDExUoZHNFx5MBoY9ZHuHk7vhnWcV94nmyVAtibt?=
 =?us-ascii?Q?Jy6LRI1iNXC39hSeU+4q9Rn2uFqizoDfLblDLhu1wntc/iNSr89ZqpMgIvXz?=
 =?us-ascii?Q?zq/g3UML2SAsofxZj6lWrdQkikR2ksEP7ZGLhU7kNskZq5aAoCZJONwZEZR2?=
 =?us-ascii?Q?UB6BLG8r1YTu9SYnFU+6hPcd28psMDBBpP9++tDdyoV7FL2kVIY/YdXR72mI?=
 =?us-ascii?Q?whloaDHhU0IsHSrwViMqr9C4gs+nyAzrlswos8gDkCqkuMMpHJOKk5fbXMIs?=
 =?us-ascii?Q?5e/fMIpKk5fXVgYvwXfua5z4NVSwzITgGECsIG7io0hVVOako5ySbpscmn42?=
 =?us-ascii?Q?1AF5+4UBDwzj7heZUib6MmiNzrS0UAfbY13GfCtX+7qYXvgV8dt1OjK5+LXE?=
 =?us-ascii?Q?H9JaKmR9g4zKahpel0DpD9SIQJx7fR+4GI2ziUIgGfQ/q671phLACNTrftwo?=
 =?us-ascii?Q?AP/l8sMSUt0BPpXfM7E9hIljFGNT7yQkJZnorQPVjXXC80QJt5+7/K7Cw9iv?=
 =?us-ascii?Q?89wg5Dzkz+4z81rV7QZ4vOdafrZ6WvYsEeGawKtsxQ+ORh16gmOH59NzIzHR?=
 =?us-ascii?Q?MYvO+cZXr9HryTf9YNNHA3CRZbRRtCg+1+0TqYbWdJhx5kI85jkFoWIEqUcL?=
 =?us-ascii?Q?8xaOItKG7I/UViuJCw8wSrlMOH0jxyKqdyUiog1op4RdYzNq51wgCvMLUPgq?=
 =?us-ascii?Q?W5mEnLnRJg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d9bacb3-cbaa-4f2d-9332-08de87dd426c
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2026 06:35:50.7018
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PKEu3pCpHe4oMerPxrFReY8D71+dkc3uNlp5On/ZAW5g4PQwKTH/A1fIyJTXIpEvkYK60oYeDB/Htit736QNcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9404

Extend SCX_OPS_OPEN() with compatibility handling for ops.sub_attach()
and ops.sub_detach(), allowing scx C schedulers with sub-scheduler
support to run on kernels both with and without its support.

Cc: Cheng-Yang Chou <yphbchou0911@gmail.com>
Fixes: ebeca1f930ea ("sched_ext: Introduce cgroup sub-sched support")
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
Changes in v2:
 - Handle sub_cgroup_id in older kernels (Cheng-Yang Chou)
 - Link to v1: https://lore.kernel.org/all/20260321102036.58734-1-arighi@nvidia.com

 tools/sched_ext/include/scx/compat.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tools/sched_ext/include/scx/compat.h b/tools/sched_ext/include/scx/compat.h
index 9e0c8f3161e87..039854c490d5e 100644
--- a/tools/sched_ext/include/scx/compat.h
+++ b/tools/sched_ext/include/scx/compat.h
@@ -160,6 +160,7 @@ static inline long scx_hotplug_seq(void)
  * COMPAT:
  * - v6.17: ops.cgroup_set_bandwidth()
  * - v6.19: ops.cgroup_set_idle()
+ * - v7.1:  ops.sub_attach(), ops.sub_detach(), ops.sub_cgroup_id
  */
 #define SCX_OPS_OPEN(__ops_name, __scx_name) ({					\
 	struct __scx_name *__skel;						\
@@ -181,6 +182,21 @@ static inline long scx_hotplug_seq(void)
 		fprintf(stderr, "WARNING: kernel doesn't support ops.cgroup_set_idle()\n"); \
 		__skel->struct_ops.__ops_name->cgroup_set_idle = NULL;	\
 	}									\
+	if (__skel->struct_ops.__ops_name->sub_attach &&			\
+	    !__COMPAT_struct_has_field("sched_ext_ops", "sub_attach")) {	\
+		fprintf(stderr, "WARNING: kernel doesn't support ops.sub_attach()\n"); \
+		__skel->struct_ops.__ops_name->sub_attach = NULL;		\
+	}									\
+	if (__skel->struct_ops.__ops_name->sub_detach &&			\
+	    !__COMPAT_struct_has_field("sched_ext_ops", "sub_detach")) {	\
+		fprintf(stderr, "WARNING: kernel doesn't support ops.sub_detach()\n"); \
+		__skel->struct_ops.__ops_name->sub_detach = NULL;		\
+	}									\
+	if (__skel->struct_ops.__ops_name->sub_cgroup_id > 0 &&		\
+	    !__COMPAT_struct_has_field("sched_ext_ops", "sub_cgroup_id")) { \
+		fprintf(stderr, "WARNING: kernel doesn't support ops.sub_cgroup_id\n"); \
+		__skel->struct_ops.__ops_name->sub_cgroup_id = 0;		\
+	}									\
 	__skel; 								\
 })
 
-- 
2.53.0

