Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012005.outbound.protection.outlook.com [52.101.43.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A9D386C13
	for <sched-ext@lists.linux.dev>; Wed, 25 Mar 2026 21:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774473678; cv=fail; b=okI3+5Q1ZecKwaNQGhQ6F+s42QLHgs1yfmn7ogOug8wRbey3gnJRvD70tWmsv56p8Hglu5pFsyKtUsRM5FjkJjGSs21KsVbpdSDF3EGsTNIJoF8fcN9PQxe3Wf7AsitHWXh+tOh9blCAt6W9gJ46q5MAXbEcd2xc/YNbN2flajE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774473678; c=relaxed/simple;
	bh=ogF9cJYjf5pvORdRW513VrO/AFXCuUmmycghuIiLbho=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Ot6lStWPn32Xyxl//44WLW9KC1R6wK47u1+JkimEYH2grWIjYVqPwoQmIOpk+wtfc/3JIMkLA6xyYl12/C2lLxP6IbyvQmTNUrpxQTfx4RPJ4bCf/9jpJTeCCPD8a4CwgSZkQNewW6DWxJXj8BKUG+PI+7ybTlpOOt8KAo5Xu8I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=P/EeIT9O; arc=fail smtp.client-ip=52.101.43.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="P/EeIT9O"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RJ10gGX++vhjBofP9b6qcuqdzqeEC/45aKW9frzG8L3OQCe62ZvRb1GKpSPXwYf2QcoHPC3QHC+8NQN4mOdcLYhGYqWLMX27qm3II35iJSwv1zxpHGeZNThtrqVpY0IVCKoldRrghZUMryCK0nITxg6zcf/1q2cCjjZKsuvXt0d5sJnjpv0TJ0BkwciHBnyRzc+A7ATxHbx1lV5kLACDAT25Jzr1ISDdewfWS0FMQDhl7qSXYPvCfMhzn4UUXFaSAVrsUUq8Y3IGUJpq5VZglFiF+xy06Zisamln29HVY8VOCdwBi8SO9wz97Wf4+VFPriIE4xOX2UEfvhDoNvNOKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sRXUL7LezeQXsbaOlTcq5CUWWK0zRtU53owvLCZCZ5E=;
 b=Fdsz/2QEDTVWCmgovfqpBi50Flfd5Ic3IQAApyITf+d2vYK/5RRj56bX9BOzp+hLwGBEl8o+43IhzrZ47NVPzBIevN17M1gINqY6C3lNEN4/DijEShD9eu4MPIPqmQJB++WNk2dXln3Q6bOYBhFW9g3OnTjHNFcD/RsUNRE1kSNoGH0PgLKKThXPaPn7Bb9EB0UNqFGq0TlF3/r1SgfHIaws1Rvnr17nKqwJowy69VP97vUuYIpqpD35HXxFAPFGxowNFncKbTF8ywnfoindruwVHFOsKxW+bgj+gZ8BYq0kTffdvjNLSCLsfxvTYH6bYKUkUus08EMbsh/NpG+2NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sRXUL7LezeQXsbaOlTcq5CUWWK0zRtU53owvLCZCZ5E=;
 b=P/EeIT9Oo/nipjTfzd2NspXdceJJqQSiZIixAutyACY5WcP/e/k7apZ4mFgjAE6F+w4SVvcHtAxSv56PzU3M2++Bshaug8IXnLmP08h8fg4KrFOFbNqXJB8Ar8N4ldp6+zvfSiG+fDRsEz4MP3k3S9qsbWUDWBf+OjFiSo8I4fMOVq3I/zOpQ9nL1FJQf/vDruNHbGS4Z7JrxUsbeXC/uXFMXXlmUxHnyE1Dd44hzN03vC8aifr9t2jkU6nEqMsbV8E+lnvkkb058SNnjG5CWvejg5Zfjaa42Y/eJi3SdUG+i14hpm+j4vqMYcMcAgtJCqJ5fLfj8JrkYVDb8d4O8g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SA3PR12MB8763.namprd12.prod.outlook.com (2603:10b6:806:312::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 21:21:11 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9745.019; Wed, 25 Mar 2026
 21:21:10 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>,
	Daniel Hodges <hodgesd@meta.com>,
	Tommy Unger <tunger10@gmail.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] sched_ext: Documentation: Clarify ops.dispatch() role in task lifecycle
Date: Wed, 25 Mar 2026 22:21:00 +0100
Message-ID: <20260325212100.511928-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1P293CA0022.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::19) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SA3PR12MB8763:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d25f7c3-3986-44cc-d1ff-08de8ab46f35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	FIRZuw2rCCoMI4ONiIpbqMeK4egOA/T01k8zEUDTKCE3QVPlT/5+9YtISWrzn11grvJJSeOGI4KKRFrXCe6hjJM9ZcKKGpMVPj722B6pzTMRQJ+GpHHUBvY1yRdGzuSlopYjN+T3xFaezE5cBgvUe60zqPFiXXwpjWUzKp/SQU0LZRaCE9Lk4i8b8fGdZ3JiMO+cRhzxg6YkAkOmErcyENVwmN6TApJ5v1/9SGdKQH3Mrb16KLvnwpxDj6sh+zFU6NEvNxfoyBCPzL0uGNDcIXOIxVhfNej7wp5QPZAR0bt/g21ZcX1Bl2R8fCq+ROcI0Ua6PAl9fUplNM4H0VBsogML1fP600CYxAv4xSNNt5ereH9caJYCODEA713kMv46r1ukoHVt+vJLNHRWS31k3jBSzz2dInbEZLdfEaCQliImJfh3JnNOun91jjoMv1bTKMotWkZMcNuQ+oGyVgW33hNjhS0UyXivOtd784jjXLdmkrcmaeXX5lcVNglS6b0C0Z88Dqh25YUJOM+B2yF8HdggFTVPaJKWjmm9V6HbRUoYpXdDonUNNG0YMYhqjaX2e4a7P4wQhl1bQbhWqvXCnENF1SGAzvtrQztMrA2VPPHrFSZk221XnPAhp+/jvKarLczKVPao8nE3Ji2j+Fi+tQ5n7TPFKWM2ldgS65ZTV9n+/+kLVC5EYr4UjJywKw7Q05xBx+cirPdLKQ/4eIODuQdvW1UtQTP9SlTHIFcHKi4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?luahSMtUuMyMpSywL8RTlQTU9cXroHS60bjRX2CbG8oJHu9hVk2CvSGjP2D6?=
 =?us-ascii?Q?qqRCSx9drRZZCiOpAEbb+6v9mpYQ2S3cLNYUGDcMMxMqWYptSrCsYntmCEwX?=
 =?us-ascii?Q?n8duVZMjboUC4AHNSj2ydv9j9ds0LoBlVgTusfqXi+P7FGIllatmEXDnX8Nr?=
 =?us-ascii?Q?1guDYTzvZno1rRmsI5TwegjxU+hRCczJMLpEGtSsTRY5ZjBlz10jaGLiAkXy?=
 =?us-ascii?Q?0gI5NsjCRlLrNdO5O5oajIh0kPihQkiEJMRpiCczVnCKQjuA9yaAcscVF91I?=
 =?us-ascii?Q?9Iq8ifrWq6YTw0q+XjMeUUmuwYWxI+cCyXyr+EuLj7ZV9/aLObXcwrNSOGe6?=
 =?us-ascii?Q?3d14cOFUe0u/i6WV8WPFycYuHQmnUhIcHVDYwxEiJ/ZEECfWr3zDHwgwcClc?=
 =?us-ascii?Q?Y/QqiY3ws7VBAcYay/fitNBlH/K3N0e+s3eCYGqGDoT+AjpaaiModI+FPC8x?=
 =?us-ascii?Q?TUaq4L5Xipf8gzPNj5xlmIhrYUknr4o+ZraezWQfLHZ8xJ19HdK6eTeHBahT?=
 =?us-ascii?Q?6ZbaG9dcHltO1pKKLNgK7sIGeeYLouSBefR2Q/0acC/++JOuCz/2L6YbtwX0?=
 =?us-ascii?Q?/eNIInF+R7Fh9uU2vTSFtX/Ivk6qTCOeO4FatYETDz+QB86nJLuq9kpRuwC4?=
 =?us-ascii?Q?elBIvPE0YlbiN0qJOYGlrsaQl4bMqoy0ilvdCOUeLzZ+McWiB6m6gjjY0+hj?=
 =?us-ascii?Q?/Exse/HD2sQF8tLzsN4KX32f3AZh0KFt2DXEWJp8pKDJOwvsm+Sf6pEzvE/O?=
 =?us-ascii?Q?HL2a32SkDfZJC+JPIR7Px6Fk8Yp1SSQRW6RVr30EZaksGlrTm2EnMcRgQlyT?=
 =?us-ascii?Q?nRlz+4325RLteAMdCOxC94xtPWGdeOHDHS8q23HkFsYAEfN7ruOYaddswTKF?=
 =?us-ascii?Q?ryGQlSY9Q0IiUo5YBhe0RGtKu7Tk1TAM+5DT0wWFMAKtISi19JEeUvN1dXin?=
 =?us-ascii?Q?EKyMj0FepELqfL+8hThrAOqJ9D3XzAZ7IAp3GHGc2UnWkey5Dpr54SS9gTKt?=
 =?us-ascii?Q?1l0yeW5POL3skuMr5kMBl0QGtQ0JuBZlJbU8mxyr3so0aTz464oGLGyP+uCe?=
 =?us-ascii?Q?cnFwug7Nwvpwx/71VenBbFaMpfO2+tGSbJvHHE6wxL+qwHA1Pxu5mXwAx0/e?=
 =?us-ascii?Q?01sqNPHQlPLtII9AhMkjPQS7rkYR/CI+ZRWxyFgFtQmt9o/UmQ2G0Mg6l6fM?=
 =?us-ascii?Q?NiDcokQWkFWn6gLssVD3tPc4FsmTma5LssLNBW6sHtkhpQ2WUtGfzDdzarFA?=
 =?us-ascii?Q?/c36zng7L3BddptaNAJ9u92PLg9jFbgA5r5p7Zl0feeWyffklOcAUqq1neGv?=
 =?us-ascii?Q?EsKK6/2ewsWU9o2fzPm6h/Huuj0jGVzbtFlOD9uBpC1P8UeqPwG8/rXxPu3w?=
 =?us-ascii?Q?M2XGRk311l/Ehiv7/m62mBTV1lf9nT0vIpZ6GuGNm3wkdoVkJ4UbyiAAscRi?=
 =?us-ascii?Q?SAbC9aXMjsDamvmcFJIthbLEAkWQcLmEVdiZzfw6IegXPsRUr/NTc2gijowO?=
 =?us-ascii?Q?8vSdizOqaiaRjTc883T84YaHBUexFhRWuPoyEsoO1TxlG9vjiANZDYYU6/Ev?=
 =?us-ascii?Q?zuCVkR6DsxT9LQUsrHFEvaR7t7jXTHtqmBt+qS3Unw7gEpA/3xYIVrUCTR2q?=
 =?us-ascii?Q?R/zU4JtEAT/qosxqnVC1HA/VDhSXt48dGsrTvxRyRwCFa8v2tiSKnQeX8B09?=
 =?us-ascii?Q?7GYarBSuWmd4lseTh2+zjpNny9LkR8BAh0Mn+EQaFd8tN8ETR1bLYP6m67BW?=
 =?us-ascii?Q?DnqMaBS4sw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d25f7c3-3986-44cc-d1ff-08de8ab46f35
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 21:21:10.1077
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q+HB2k6u/RDPctWmDuwmwiO+2zH22tIpjttFIFFanff6MNV/H7rqmEeSa2d/uOsrkIeqNa6bloIG0OgeJXw3+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8763

ops.dispatch() is invoked when a CPU becomes available. This can occur
when a task voluntarily yields the CPU, exhausts its time slice, or is
preempted for other reasons.

If the task is still runnable, refilling its time slice in
ops.dispatch() (either by the BPF scheduler or the sched_ext core)
allows it to continue running without triggering ops.stopping().
However, this behavior is not clearly reflected in the current task
lifecycle diagram.

Update the diagram to better represent this interaction.

Fixes: 9465f44d2df2 ("sched_ext: Documentation: Clarify time slice handling in task lifecycle")
Cc: stable@vger.kernel.org # v6.17+
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 Documentation/scheduler/sched-ext.rst | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/Documentation/scheduler/sched-ext.rst b/Documentation/scheduler/sched-ext.rst
index 9e4dbabc03c0b..404b4e4c33f7e 100644
--- a/Documentation/scheduler/sched-ext.rst
+++ b/Documentation/scheduler/sched-ext.rst
@@ -433,13 +433,15 @@ by a sched_ext scheduler:
                 ops.dequeue(); /* Exiting BPF scheduler */
             }
             ops.running();      /* Task starts running on its assigned CPU */
-            while (task->scx.slice > 0 && task is runnable)
-                ops.tick();     /* Called every 1/HZ seconds */
-            ops.stopping();     /* Task stops running (time slice expires or wait) */
 
-            /* Task's CPU becomes available */
+            while task_is_runnable(p) {
+                while (task->scx.slice > 0 && task_is_runnable(p))
+                    ops.tick();     /* Called every 1/HZ seconds */
+
+                ops.dispatch();     /* task->scx.slice can be refilled */
+            }
 
-            ops.dispatch();     /* task->scx.slice can be refilled */
+            ops.stopping();     /* Task stops running (time slice expires or wait) */
         }
 
         ops.quiescent();        /* Task releases its assigned CPU (wait) */
-- 
2.53.0

