Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010028.outbound.protection.outlook.com [52.101.61.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86300456E04
	for <sched-ext@lists.linux.dev>; Tue, 28 Jul 2026 15:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785253501; cv=fail; b=fFXgIIG0mnQun34HMZBHUM5G5rIQigPuDYypgO+bXWmiJH2znPqEZt4UvQeoUI6Ws9pOWcMxVqfHPBczFcgTWBhngreNM74FxJCQ81mK+gGsmBbdejipa1l83zPg4ig55KDDaKxahzJ6LTou/wvss81oOhCkuC4pGUCTj8CbCpk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785253501; c=relaxed/simple;
	bh=QM43rFv9JH6ZA4ilAVcffsTACuIOGkFZVBnIB/QZvlo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=m0TLD8QyNynwXByX6WnxJ9xbMBXXL9IplPwJm3t8pKYcZbMLPoDnlsNjzHIwKeGbFWgmTHicUMURRi9NEOMmzvtyEAwEdcTipZmnAsCj0UpVj2Fy81F1yjn3chD5c78Sk5S6OP3A/1w39ssDmwuKxLmdG5WvFFeRn0CQnsofiek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bPsu1H6Z; arc=fail smtp.client-ip=52.101.61.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bPsu1H6Z"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wDflb7v+LgqvQmvbeecXjwtoCHs5SemjgO5xiFBLzyLcfNWKMfeeNAyvCd+5uueOd80UTPwYwnRyDwgR0YNBEX5cHrPMO0zieBsn7B4mzXQgchlDuk8wCz4SNND5EpZr39Gv5JTG/O3kCZIKIFPuDW6Ms4+2t1jQvOANj4FQWn3IW23z7TyNX1Xyr+E9EJhxBVvnOTOtlnRQ5EngMNWWQAZhgKm4wjFcepCobq7lo+0N+qYAaNX5heUnLzXGbYGcS9Z12rCksjrmOPFl5MEgp5TtjMrzT+f8gcpnQzEx0so8mwfNCJCCz4m6jrk7By+YFlmnQdpWoeEBnQqd9B0O3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/cgdSbZ4L9wMcWYUFo0Jnk+RhdiDycvK0mieqoERmGU=;
 b=VXHkTlMT7OiLuinQtx7yT7FQSmafsTHH+nIjI6PbXghfQyVzg56326Jx0qOS+tqxMwTBrgm5v9aMFV7ksGGZNyp18uC4+X0jbNnskpmWkO4HDsSGXPcyWYC8HzJd3yZw9hIQg4bNIrLYW01erFAaGlbFn+oPfy6tNdFokkkoJ8WXAYyfeUOll1+Lf87pyMai48SAlN48pUmO5A/XnSzGDNiW0xwtlMwz9QO1b0Rh4j0BgbHFXJ0tJQ+fmbXfWOpINsBmeUBAfBu9Y0atHtYICZ1uJHjv12erqm0zkDXXmU8NBhwURo1YljEOeTRRp0WRCPoc/MTUWXRR2mvujVuRnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/cgdSbZ4L9wMcWYUFo0Jnk+RhdiDycvK0mieqoERmGU=;
 b=bPsu1H6ZU6CKN3VeCb0MlM8EsdwebhaSQ+dIcSkh8rciZf999HoXMwSOcbRo0u/6N1pT7vfzfzinLZfNxEA1CZg3qMNR1s6ZWY5LvGtQmHbk+KKB8Ddm5NHdpuT2nk1s0Zd0FqTg+biYbaWRyWcx5W1lhIXj+WLnSf92dYFln7fTOtB7GNCrhtqdCEGdh7kN7KNMxqUeRQUh7n9jDA9TYhx4KdaqUIKekTETW/Xo5RyEnGQBr8ODl466toI1y1/kbUwnx5k0YDj9qJa2rQcDX7O6SNneX85nTWHYgWsuIEhQ0i0aQpmX/OuFbP3PoYMCz4G4S3xkDtSFBsy/hvFEDQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by DS5PPF482CFEB7D.namprd12.prod.outlook.com (2603:10b6:f:fc00::64a) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Tue, 28 Jul
 2026 15:44:43 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0245.012; Tue, 28 Jul 2026
 15:44:43 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	John Stultz <jstultz@google.com>
Cc: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Christian Loehle <christian.loehle@arm.com>,
	David Dai <david.dai@linux.dev>,
	Koba Ko <kobak@nvidia.com>,
	Aiqun Yu <aiqun.yu@oss.qualcomm.com>,
	Shuah Khan <shuah@kernel.org>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 01/15] sched/core: Avoid false migration warning for proxy donors
Date: Tue, 28 Jul 2026 17:43:19 +0200
Message-ID: <20260728154425.1549660-2-arighi@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260728154425.1549660-1-arighi@nvidia.com>
References: <20260728154425.1549660-1-arighi@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0211.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::6) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|DS5PPF482CFEB7D:EE_
X-MS-Office365-Filtering-Correlation-Id: 0029f0aa-7b7c-48ee-a8e1-08deecbf249f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|7416014|376014|11063799006|56012099006|10067099003|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	+OHVIaIqUuW85MPVVqERIoQJOokli4ZeqYewscUR/eIpqt5xRYgac4rNSpiuC7fZBWEevJi4GC9lS320ytzMtDjOu9eTJ12XP9g6vBc5YPFBZL9Xwa34yqqHYiDyFS/IwuLw4L8mh4MxxppjMPU4UCo1hkBDF6y+OaZfE1xfQc8ojbKbt8LMpa7tyVru1Gbw/8Q22Df3YbDZax4p8wE6WW61l+sw0jqO9NeHNV9ta3xPcvJBsrAlkdXQZpj/3g25kAYMfesMj0lbCF8loGuuicK1BU3OVHpZTjS/B+svEWSLE5+nRiYT0P36I9n6Vb2uAozlKxXsUE7EcLpT+YR7ZY3NyZUVTFaHDWcCwJs0W81SARKZOgvpXbU5eW/ZN1DAPbyCq25c2UPcxW1Y8YRHYFBq1AbSYhDjxN4hgDu7GcVyQq9R4Hmz/a+cOW6jTdU+5PeCtZVW39r9ii7l47QmguK/8DeErrU73ovGTndMQMTEWx+3r1/6R5ThCaGEwdeFB4l8Ryww/APbRTo+/aoPoFJbcY4nj7wkKU0jBfVoAcBFgMyMNx2WZVLg+u6+In4TEA68TdinkDNozNkqA502wMYf8v9Fh3q0qUQ5GTIQ9ducHU8vqotFlmFvmrGIotiB5sttqjbuECOQmKqp+QVIt7qsVhIiRQBfMXh7IpUBWX8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(11063799006)(56012099006)(10067099003)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4LbnL1d+NQPZojC3B+KTuXT4xCskMv5gJobU+gDowL84yWCYNzuwQoWOZz0R?=
 =?us-ascii?Q?rbcHzdLMxXg2jcUiKnboPLu9li9gOCAvGEbyZ9H6JKWL1wT2zVhHGmNEnEWD?=
 =?us-ascii?Q?VaZ1ceYIVT6Rkewjvp5B1PoU3RCBtVYfTfiw+2eSj0XzjPOr85pgzfcfVXMs?=
 =?us-ascii?Q?CojXLXL+XJMvtGnYmtDhY5S/SXinerfSe0jhF4WH+XsTlp2qaVIt0TCuci7/?=
 =?us-ascii?Q?Z3v7kZXoDkor9Tr1YhhNl6Eum7+F31WfqN5EA1eApk7QMMdlGkbvG5qulEKU?=
 =?us-ascii?Q?rEbp+m6lvcBtAysyUmdoTXmGAms3tQzRHr3VetAcJUMnj4b8/W7FtHT/5c/V?=
 =?us-ascii?Q?pPyQ8IHGG/t1J4zjMM4WXWDAGS8PuMg8N01B3QR6gnatAyc+bx0tRpQducLq?=
 =?us-ascii?Q?9LNusYruGx6wCpUQjs0AX/CwqApoJGW7Ldvj5bA82MGQFJZlEVJAoV8YjzD0?=
 =?us-ascii?Q?cwulDqWqCiR2H1RMeP7v5BsDbmsZDJ1Fay9wzbAtSXM2czLzRg7RdW15oqap?=
 =?us-ascii?Q?e09qyTpX46otFEeDzmKxWihmJ4fvCr4TrK+Fmar6cHkzcEuGLQem5RUY2ffU?=
 =?us-ascii?Q?BmtYNb2F2VZNvJTOVwV8jtqXgIBqOEK9jK2kNdRAwHi3cL8yAPSG04IKCysp?=
 =?us-ascii?Q?Ajcrf+HMnlvoVTAdiQKnUczRY/GF79JCl+l98fZGXCoyhvbV4WjKkQpOUyt8?=
 =?us-ascii?Q?phjsjEbE0xWYKyteLyc0qgu8yptBncvfcirWoctyClwOpYl2xlyEPjT7lhQb?=
 =?us-ascii?Q?4lxZ85ZayA7GMB0WB7I32hnuRQdg7x4ieYNP73lchyc23AxDrN3fRFN8v0YE?=
 =?us-ascii?Q?lDBJRPQt01HJAifaoqqmVKO9DYzd2sg6zeDCexqCkMBtJ+/Ybl/3StNYSaTU?=
 =?us-ascii?Q?9a1+9qjs6rexvaBxWfUm1k4n/2C34Nx4MWvWHXHFKUzD3zm5EeAY4kLDvk8Q?=
 =?us-ascii?Q?u50X+Rl0SB/STPN6DGRnmhRWvVirnQPbQAl+lajNwYzt5wAVZ0IrdqC4ju0c?=
 =?us-ascii?Q?BbNemJmAcI4obiU314bYtdcgrSWLX8Qi+Pug2G0jdpYY1CBhUJyPZgT48WK5?=
 =?us-ascii?Q?wYAYmNXFJ1cdj44dbTO5XHEImkgPC0YGtYw5Tolj1TgMd+ct56GYGWsDzqsU?=
 =?us-ascii?Q?/aYWl5A4dhMus3xONzXqJcap1VakKSXiKdeUYl4DPmYR78UdImC09EP4QLjQ?=
 =?us-ascii?Q?wp45lIva1Ff9utkEYKI8jtKqE1MbEsxIfyxXdZ3jUnepYWT3zA1e8igghvDT?=
 =?us-ascii?Q?iLALdzC75OgtvMsYH8bwm2gbD9tW3KkUeROIelQ15hmBtc5T54IeX3BiSMxR?=
 =?us-ascii?Q?gRPKn9XPbyaqOKXjEaeMLzmUEsIPYfbprCBXWoa9pfhs828JbwZ0YdCtIzyd?=
 =?us-ascii?Q?L02hZBboWOkaAEMKVSXmc1RXFQvXlamvBnBMwAigdpa6nwS5QNmSMwv/aN5q?=
 =?us-ascii?Q?4LkrLv/3g52X690sy66tUHhsBuWSBhhPtzuVl9H3FPR0eD74QgyJ5gWj3Ffr?=
 =?us-ascii?Q?6ySu6HbMMCsqFjP05k3MHRqSxUqTlySU223dAd0vdJFjCLBZ/gMwn0Orj1WL?=
 =?us-ascii?Q?N5E+MG4g2UeRpc7N4VyPuh9dfnHUHHN2QgMtQiOPZd4wJp1mrBuZnqT9/LEV?=
 =?us-ascii?Q?9Af2RpegLTZdP+Bc8c4ls6EIsIXFY12/5QkelsVtLChLlKk+RZ3dGUEVoCS/?=
 =?us-ascii?Q?JdCON4C/ITyPQc0BfmTOMYYewC1/ujPBIw0E8HZSA5PLVjypFsUEOBdln7f6?=
 =?us-ascii?Q?c8C8djQY5A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0029f0aa-7b7c-48ee-a8e1-08deecbf249f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 15:44:43.2159
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TskQYpvgpu2jx0o1XEHQgViq6M6QOQRT7JVVbRD0OMdoApMakHOwOlA4CNIzuB5wKePtEnwvUlwaAcNrcKihLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF482CFEB7D

Proxy execution can move a blocked donor's scheduling context to the
lock owner's CPU even when the donor is migration-disabled. The donor
does not execute there, and its original execution CPU remains recorded
in wake_cpu.

set_task_cpu() warns unconditionally for migration-disabled tasks, so a
subsequent proxy migration or the wakeup path returning the donor home
triggers a false positive. Moving a blocked scheduling context does not
violate the migration-disabled execution context.

Exclude blocked proxy donors from the warning. The proxy wakeup path
restores an executable placement before clearing the blocked state.

This is a preparatory fix for enabling proxy execution together with
sched_ext.

Acked-by: John Stultz <jstultz@google.com>
Signed-off-by: Andrea Righi <arighi@nvidia.com>
---
 kernel/sched/core.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 3cc6fb1d20547..e11fac7f805e7 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3341,6 +3341,8 @@ void relax_compatible_cpus_allowed_ptr(struct task_struct *p)
 void set_task_cpu(struct task_struct *p, unsigned int new_cpu)
 {
 	unsigned int state = READ_ONCE(p->__state);
+	bool proxy_migrated = sched_proxy_exec() && p->is_blocked &&
+			      task_cpu(p) != p->wake_cpu;
 
 	/*
 	 * We should never call set_task_cpu() on a blocked task,
@@ -3376,7 +3378,12 @@ void set_task_cpu(struct task_struct *p, unsigned int new_cpu)
 	 */
 	WARN_ON_ONCE(!cpu_online(new_cpu));
 
-	WARN_ON_ONCE(is_migration_disabled(p));
+	/*
+	 * Proxy execution can move a blocked task's scheduling context to any
+	 * CPU without moving its migration-disabled execution context. The
+	 * wakeup path will return the task to a CPU where it can execute.
+	 */
+	WARN_ON_ONCE(is_migration_disabled(p) && !proxy_migrated);
 
 	trace_sched_migrate_task(p, new_cpu);
 
-- 
2.55.0

