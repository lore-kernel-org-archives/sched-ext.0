Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011044.outbound.protection.outlook.com [52.101.52.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A923B3886
	for <sched-ext@lists.linux.dev>; Mon, 11 May 2026 08:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778488313; cv=fail; b=CC9+hEy0j8PKG+kPiHWmtqthjTk3axD7CefmVCjD4d5YuCyPeQ+SplPlCmPol7HgQ0Vz3Al/9547oRHhntAZrGsQ+zLQGUKlr+Uoh2EREPCiYHifMtEIs3Qv7Aihur/bx47T8obojZD6ltXA44HIyn3dVAltnk8sOj9t0J4TZEo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778488313; c=relaxed/simple;
	bh=hIIoglGt5TYlF0Nx0HFkJVxJMJnDJ7Me48FVIhfGbNM=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=sQhdvSMQewSX0Dau2pEzJiSYp6kp6BeCAw7jBOiAm0uZpvWzsnefPTS4lNJ/8YZHNB3wQYugUNCzZcdXetKRaZXS+ZHXLpCpVf+jgHgYP9LLBg5h5Fiiv4LJCVL4lOinoOtLeJnJbT0NkE7c6PlubQuLESUuozwLbe8jzqezOA8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FP9vW05g; arc=fail smtp.client-ip=52.101.52.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FP9vW05g"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d5/aNT1co84X16L5bZpGtDJVId/Oy6AIGR8CbQNmwtG+B/tc6DO+Tak4NyHJMYWjJaRSwDcbXO/NanMWFZ3RZg+XnauOvaHS3UQNS0jIkmqCsfk19W/C/DEbrdSpOqqgGUrZepuC3yK1euyv57DEzVDoav5TjQtW8fY6CBDGBDyznY/khQpxY7bBQPIJAhFBJilT5lN58zfcCMJLgBaTxpbHcj61JiEmmDu01epEipcmBV97bDvzpBm7T4Vmpts44X+cfb2j/o80DKgtbwwu2vkUTTO2+W9SHzL06UrmngH+6XadzDO1lA5uUndjoOmeFTIZEd2lbH00ptAN2o6ptA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8XjoNwO/c0EOGfWbQKzzgm7/yiCcJL+WCf+XK3V6Wgo=;
 b=cxR7aQnyllFZY4FKEEYgWPY43k9z1K2zmJ1OeP1g7kBka476qsLSRq6kgiN6TQu+d4wYzW8dA98370Dx4yORVqMF3YbIHlAjJ0jq1yyux57zLDlK0x2bo8AlYwJKicrTgPVFJbgcxeJv4VWp0vNMIxaSaKlbN+Xo4SHmPuNrf28chfFSa9J5H6LU0sUrHNQUup8vCTW4i/10r71rPOsfp7Bg94cx5quZFLZKTWnKnJir09LlkVbPql9z5IWKd3toRed28UgW4bYdoWLjKSg5BEB19b5dSQ+hrQnw6/SCdu3CoQyaXFwsarm5vwdKVd26hQkWltczXHKY4hYsC8u66w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8XjoNwO/c0EOGfWbQKzzgm7/yiCcJL+WCf+XK3V6Wgo=;
 b=FP9vW05gDgRmE0P3GdzM+QF1fu3GpobonySYLY70pGp3mvFSV4EmT8AjUoMURlQdY3jZpU/uhotsXTPj+/rL4XFdqQ9vdEHeGMcyl6kDk+OhKdT/WDQOXxKIqCXRzDXKT86LMJV+aJKAnH0VWHIKjMSgo0Xz0uevELrPiMX4i8jnbWNBfdarnvESfr/LJ6YWrABUsMXMoen2odoZtSKMCm2mTcZQk1qljMOqFmEYocgYQO+mWnrkE4Wclx98BYOjLx3qGWI/kZMbBRza5VQHdI5wve4hijZE6kRtL4IEBWSskeSdSKr4CpjKhEuUZvfemeHn72M2noUggsppR9xpYA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by LV8PR12MB9112.namprd12.prod.outlook.com (2603:10b6:408:184::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Mon, 11 May
 2026 08:31:38 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9891.021; Mon, 11 May 2026
 08:31:38 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH sched_ext/for-7.1-fixes] sched_ext: Clear ops->priv on scx_alloc_and_add_sched() error paths
Date: Mon, 11 May 2026 10:31:30 +0200
Message-ID: <20260511083130.3174880-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.54.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1P293CA0003.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::19) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|LV8PR12MB9112:EE_
X-MS-Office365-Filtering-Correlation-Id: b7dbe696-da98-4f0d-be20-08deaf37b7d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	bqgrSsEIs2FV9bFOwzzi9p0776AUBylYZCd9+SYaCIHx94LTA2dbNUGif6qDpnUoXucJDU9YR+HPe319z/nybOUpsApvJMkKvW5iDBSazJWxmFlt7shFfmWCBnCCb2zTuhsABs2t0Be0Q5OlhGHE3as9lqKnfATzh3n17ArHdAXnaojn4oDATME+RfM1Shu1He9RmnSuHkfzQgGUxGhYf9hicwpRSwzOAq3UERgDMWXL24z17DTcaTP/nF3GEOL+XJughZ33rUthRfJA+waLjabwUmJswEOTvmb/xeeN3CmKaXG9VsxXUG3cbZgAfNBskB/mgTqo0MMdiWoK2fBCzzDNm5+sYSnfEtrnUt02n533ufGQ5gB6UuPopYAHWLEIGXHQKb749M7Wd00ZMGPOB7FbkuwF5YaQhugT2kSpVkZXuTuj8A9k6R35akbdKW+eJvOGGNT+V6b9CMarToHPsuCBrxg53KRpD1/JmHMCzlDAtQfR7HadXAi+26Nom8ErMj3DcXXVuI+H9UYLgybd9f+JWsgLAl1yLcpowKzl5VX6/PPwHak8o8B0hSvNQ/ZeRCtYaqi+QDwhk9GCW5PsiIwrT1caGNtDqCsTrWiyGOYMf8b5rE4x5wQylaItBJ8AKSCxYgtgjMUsrnBqacnG0XZ3iccSb15D3pNutE2TVr0jUYB4hgRlTmM5qwgf2qI+
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?skuA8DfKFQLRaaBKhk2evqQ35g3FcavJf7ScCDbsA/uLBp23XAlC0gWNQ0RF?=
 =?us-ascii?Q?XXgoL0LWjqx5A6mOwiSExVzH83m3bkZOcsb32xVoipQCsJ6FJrqwlxIKY9qw?=
 =?us-ascii?Q?bXOTiy/hqUYFeWR68YOUvrMFoL/Ylyj1ocBECDyAvvqjKrxdwz3tqIRVSsYC?=
 =?us-ascii?Q?MR1dAIqyzjqevtwY4H0Y91vvC2DDSehPapgV8iWWkpxuEVG1OP1Air4JODny?=
 =?us-ascii?Q?2RVj/2LcVTIKYByu1ZdPUkEBdLcw0htmkrvYT//cbRLq1cl9Z89Ay+Aciavr?=
 =?us-ascii?Q?EmMIEwIyoatjaTsKTpY5agsRsVwW+M1+EwP4R7xpXEuhi33OarOeM6AFOuKD?=
 =?us-ascii?Q?ngJ26/cKRWYKmdRoRH8M0vNAUZIX1ntb5fK8cfS8OTv04IGaUb9frHQYjNRz?=
 =?us-ascii?Q?kMNunfcThEFSUZoS14qAbXq3XtscXyHeOBJp/bkr5ePv1N4gZWgZTUCvpHlD?=
 =?us-ascii?Q?LO0QbyPjMsts/6ETovAgXqFy6QTjjPKZ5Mvj4t/PVnrZnIRDSak+DVQfhArN?=
 =?us-ascii?Q?Ph8LrFCZcXweiJzD96u4rj1bi9L5203gLxY0Q0sunsOfaTEby5n6V4g0q9eJ?=
 =?us-ascii?Q?IuQVo44IsgRNUDHu2jUTa3KAEfk4bXPMRuMwwU9qa2ikuxpiDiFz0rCjpcvO?=
 =?us-ascii?Q?5Ui24rEQpZIPbHs90Zlw3BN1UKX2UZ6RoGqPGbiEh5WotBkNPuC86Wc9DZnc?=
 =?us-ascii?Q?kE8okZwLQRcwkfKnXyevYuf9Wt6CaDPGGeIxzE8R4hLVma3uS3BDvvKigB8g?=
 =?us-ascii?Q?anHTNjp6VkGccsqAz3gB4xbexUUYWHRsvxay2vrIT/sULa66Uz989xF2a+ag?=
 =?us-ascii?Q?K52coXinUvnEZ9r4hPxcGvjhkTcJOsJcJI6eYUvJ7DP9WguzcWEAqzJMS9ZK?=
 =?us-ascii?Q?RJXBp3b3toIO7KrZ9Z3gO7ZglATZKbGjKlAnnmBsvjC2tqVsz9ryEmItMgIq?=
 =?us-ascii?Q?KNxnHW8haiheGwDwZR0BcCzfAC65QfmHxj1cAoD5F8F1fhCZTqqeiFJ4XhG1?=
 =?us-ascii?Q?wRTJM8z74up0JQzRb/xMpMDLwzbHPUN3EMphkYfRghFi5EqeoEyZK+IFsF0j?=
 =?us-ascii?Q?8QKXPakVZ5peSYQFi/dD+OomMi1HhINWTryIY/yWWT1VxQ4O3N76B6E8JjYE?=
 =?us-ascii?Q?iFOAi7iy0jJUWbxxOKiWCcemsrfgiLq0OMIXaZlJmiYLXTH+k4HwJhcRXgm+?=
 =?us-ascii?Q?PFAXNTA6y2mdoTXVUsTBwf6fEF8CUTJFtiocJFRWPI6sONYPoRGOzjXIEgxi?=
 =?us-ascii?Q?dUOAbjrseDYkQ3c7iUAUN4HTtefOmZrjDSjaQmwAJ8olUwnuLJBFyrzLsu5e?=
 =?us-ascii?Q?TRsKWo52mip/VXHTVuI76VekmFx5hmwxFTKO+0LkULxdNzOIM9iA30SG64wO?=
 =?us-ascii?Q?nwq2TygwJ05pfjRmSd7wIgbsM2dIGqtso1njYYTX4Cp+y8hYlud/uwLN5uUo?=
 =?us-ascii?Q?20QXjF30kYBivC9Z2ijCp2VdrAqxrZ5g6hn5GtO9ywVX1+tT4ERdFXzvDVud?=
 =?us-ascii?Q?VnuzdGk4FDDBn8YEjwI1sa7mHYSSVr4AqgzN3WfK91a4ytyVAr7PQfkiWM5l?=
 =?us-ascii?Q?kENfY9Y28bzo60H8LG3zXMO1kBPFKFY6NmfraoNF65SfqMxl8iAruKuXHt1t?=
 =?us-ascii?Q?lmMUpmDwOzrtFit4FSZCOB+10TSMwB+LxAxdY3l5Wu3ZmAMA2TNDGz2Dedxb?=
 =?us-ascii?Q?fjVSSQ8s5j8EeGjCMBC0S74qfDouq7J+PSDvkXwwB+kRCRTF8aYDofYYLA27?=
 =?us-ascii?Q?HlkIEHslfQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7dbe696-da98-4f0d-be20-08deaf37b7d0
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 08:31:38.3130
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fkeU6qGp6waci6+qc13ATueNYVxEKykkC/uQCWb7aDMFnOunrSr77XqtO1L6Yu1uGJqxPnNL0Y3vzO8OuJ5iTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9112

scx_alloc_and_add_sched() can fail after @sch has been assigned to
ops->priv. In those cases @sch is torn down (either via kfree() through
the err_free_* chain or via kobject_put() -> scx_kobj_release() -> RCU
work), but @ops->priv is left pointing at the about-to-be-freed pointer.

With the recent -EBUSY gate in scx_root_enable_workfn() and
scx_sub_enable_workfn() that rejects an attach when @ops->priv is still
non-NULL, see commit bbf30b383cf6 ("sched_ext: Fix ops->priv clobber on
concurrent attach/detach"), a dangling @ops->priv permanently locks the
kdata out: every future attach attempt sees a stale binding and returns
-EBUSY even though no scheduler is actually attached.

Clear @ops->priv on the post-assign failure paths so that the kdata
returns to its pre-attach state when the function returns ERR_PTR().

Fixes: bbf30b383cf6 ("sched_ext: Fix ops->priv clobber on concurrent attach/detach")
Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/ext.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index c49ada0a89c7f..1e635174a8bc7 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -6667,6 +6667,7 @@ static struct scx_sched *scx_alloc_and_add_sched(struct sched_ext_ops *ops,
 		ret = kobject_init_and_add(&sch->kobj, &scx_ktype, NULL, "root");
 
 	if (ret < 0) {
+		RCU_INIT_POINTER(ops->priv, NULL);
 		kobject_put(&sch->kobj);
 		return ERR_PTR(ret);
 	}
@@ -6674,6 +6675,7 @@ static struct scx_sched *scx_alloc_and_add_sched(struct sched_ext_ops *ops,
 	if (ops->sub_attach) {
 		sch->sub_kset = kset_create_and_add("sub", NULL, &sch->kobj);
 		if (!sch->sub_kset) {
+			RCU_INIT_POINTER(ops->priv, NULL);
 			kobject_put(&sch->kobj);
 			return ERR_PTR(-ENOMEM);
 		}
@@ -6681,6 +6683,7 @@ static struct scx_sched *scx_alloc_and_add_sched(struct sched_ext_ops *ops,
 #else	/* CONFIG_EXT_SUB_SCHED */
 	ret = kobject_init_and_add(&sch->kobj, &scx_ktype, NULL, "root");
 	if (ret < 0) {
+		RCU_INIT_POINTER(ops->priv, NULL);
 		kobject_put(&sch->kobj);
 		return ERR_PTR(ret);
 	}
@@ -6689,6 +6692,7 @@ static struct scx_sched *scx_alloc_and_add_sched(struct sched_ext_ops *ops,
 
 #ifdef CONFIG_EXT_SUB_SCHED
 err_free_lb_resched:
+	RCU_INIT_POINTER(ops->priv, NULL);
 	free_cpumask_var(sch->bypass_lb_resched_cpumask);
 #endif
 err_free_lb_cpumask:
-- 
2.54.0

