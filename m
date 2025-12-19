Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011047.outbound.protection.outlook.com [52.101.52.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22122D94A9
	for <sched-ext@lists.linux.dev>; Fri, 19 Dec 2025 22:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766184319; cv=fail; b=R/K/Vjap1P+QdvGLzrj+yW9FVxgNxqUOMPVZp/nsWB8sg9J7iG3JRe6RHHMy2Tq9MBnP4rPzONYMg5HRKFA+tWAdgpkf4a3CfAYm4UMu1RP0Pvg7A3F3Fr3yDgkR3Mkiy2b+55qtIarfQmHW1ETTQ98uKgwfdifKk+M9wCYxHJs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766184319; c=relaxed/simple;
	bh=tqyEYPs7eRg9gsG3w8e3j0btaxaNHtmSRolDWitfheI=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=jjp7BhwPC6jKY1yOfZ9IUi7r9lXipKMtqFd/Y76924BoBg8PhhtPU6/Z6bfEt+P4bmpsQHB7bUZ4ClTUueNBBwBJqnS+ayDgt9p9VcWVcQsLwwns2OKqku9FCHqZE6AcBq50liIBYI808H4EcRt6/vrKg1HVpY5SQ301LCl8HFw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MoM0HcGg; arc=fail smtp.client-ip=52.101.52.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MoM0HcGg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dWbe8aGfwNWCezCJza/hz3AHqd5wlv+7AfnK6JUJ+ubsl98VCfjlgI7p1Ykpw04v0t/ghB2Lzz8MfCQ7W3XyrPKBWwrieziv2J0D513sfGyM6SdH19IPwLPY0NhOQgLCf5Y/+RN0DXO+F+cQlO/WoupCrHLPqshIYKK4QMFOmYFOSWkNiKlGPrLtatKBcVhuuD6h7BIDl1SEU0mVWxmAWIlBWnQWFJdIdsbdYRfj0YsiRhGlhrj1OfjW57IeZ8vs3jGsZ7LtbI+u8O/Wr0U89FVqmXV6jH9iAxCAh+0MroR47NYllnesDWwUxe9rSPV4rqYlN+eHi7cNEDiVlRZn/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FwP+mKrJxLKs+cng6aASZalisv0VHSztD74P1f2z3PI=;
 b=LxKmj43gFvzoT4ip1Bb53pZM3OvkGV+S4O83u6NQIDVtKxCBi4yi9iHP0b7iwZh+Ma8eJuaLoyMd8CdWqFxq/qti4nxlkIPntt6sbwljhlOLabOWTO8eMreNzeH66+wUFJ4PAhfhcJpZaVXBbhJMk+q5InCMA3yvXnJZBYlrJfOgatT853RA4hc/3pt3U7DKYGcGA7y+EL7MlqzgVwm29g7YNZBwSvoz4QXa3pOC7NZ9G+2LDwKhMcBp3GfYL+cCV490UAGtJ16xW04pU9NLWRKu+2HuoqRLQUsl7L3vD/Sex9yKlEuNwZTx3/HJnal3KJNT3Dm3TskWnlVVSQYPEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FwP+mKrJxLKs+cng6aASZalisv0VHSztD74P1f2z3PI=;
 b=MoM0HcGguFAqVKDTe0WCSU1DDFgZqjnZ+ndZHOnL66sn0OytTXNt8RrnJUucYbhzlN9UEInWFjMi0PRL6t/TVOBTMvsZfmwpBPvU/ZNRSUx6I91keH1AdI9fjShPBeW0ExXTBmEqI/VZ4cNE2dOFnT50kl1JJ78xY09OuIlNoEvqE7Dov4SNeZqKc+XJ9JkFHrBLJWodyfzS9m5hsONSK8XP95yxvmuw4b6D/HzeNqmVT6hqqUr47Hw/etRTDEMM9cltmfAE/z/nCc1tciGOH5TZIlECGFB7RKBz2BCoJpJFhUUFKFqrWYf+G+uU/gSvEVhjuxHrch3ocNMF/0FuPQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DS0PR12MB9421.namprd12.prod.outlook.com (2603:10b6:8:1a1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.9; Fri, 19 Dec
 2025 22:45:13 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9434.009; Fri, 19 Dec 2025
 22:45:12 +0000
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>,
	Daniel Hodges <hodgesd@meta.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] sched_ext: Implement proper ops.dequeue() semantics
Date: Fri, 19 Dec 2025 23:43:13 +0100
Message-ID: <20251219224450.2537941-1-arighi@nvidia.com>
X-Mailer: git-send-email 2.52.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1P293CA0020.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::18) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DS0PR12MB9421:EE_
X-MS-Office365-Filtering-Correlation-Id: 366088d4-fa3e-41b9-c76b-08de3f50455d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Hhh+O3O866w6+02mbwsGCCxTkeiIvU6V2YayKHLn0D5aED6PGDEf0SfoePA1?=
 =?us-ascii?Q?4lCHmy0T6qmMURJwl82DeY2gXi9agUhPE4ZqYTevuF6thlwo10Uw3NAXYKM1?=
 =?us-ascii?Q?gfwPcaU2yeCTFuIBWnef6aKEFoRj6DgVxJ/zfFhILSRdM1h9DizYqRAOqxz2?=
 =?us-ascii?Q?Ln+esQkq3YQ0KP/sMiViyEodHDh7sgVG1KHUZoK2XBXFOUHjnNsRSJ1s/QRw?=
 =?us-ascii?Q?Xd2utnbxmzR4VrG/75F4apBrEBPFKNqwUpqVLKMZo9KmPqhzy2Y0TcRoKulL?=
 =?us-ascii?Q?/3EOe36FD/Q5g7QJi3XtkT7aqvIFauWdtsn+Qlsxaf4QvLJsrbi4oFx6/y0B?=
 =?us-ascii?Q?ziJNHrOT0IVmvGgEvUWiPe+4Rcs60X6BFZHj1+j1lESu2w2fv09+xlPYKruE?=
 =?us-ascii?Q?uVe53izqnHp7PZSs3saBMkZCb46bqHFMQgVZWPvOCo3iaOzkfSnWX+TmOVPR?=
 =?us-ascii?Q?7IwhLxAhd2vSOJv2MsLRjha6hBUDbNhIw28zuk4PjjqYD+P6Ig+9xv3Q4qly?=
 =?us-ascii?Q?gF3sIZH1IMsH3LUPe4S4XqlIchn8VDCabpQVkuU2TeuZP5udnDtSCvX9qbKb?=
 =?us-ascii?Q?8f91VTCisjwLbiBiSzfqbj+U1JJs0ArDfVX8yP/mrrQWtcsCwiOOk60mWcLB?=
 =?us-ascii?Q?7MsnVzfPe3/HekLXNUkG8IvzFJ0M1/md0FSJ+FXICbVL9YzDVXru0h9zNv+9?=
 =?us-ascii?Q?RnbgM0o7CgOKwCJPsUyF5Bx0fFbVBffEAzhq5sK/p3EUIIiBcsZ6mpqbe8OJ?=
 =?us-ascii?Q?MX496jE4CibM8rregikK3o+aJKgoUFq1B9ZGpDieSODWet0QwrUd+2NPXZk2?=
 =?us-ascii?Q?EAVaPeUaaM73IHHXLnF4MHwesEqw26srPCP+IR6ITXH7hApQ4X43SoLIbvuh?=
 =?us-ascii?Q?MNsGEJCw/d3DeA1MmjdpdB8XXET4omfZ9j5+OWj9FKsR65Eudkkc5J2pEHTt?=
 =?us-ascii?Q?LZOU0aSlH3rWLtSsn2HM/aZMkhqL0TkaM+Tm0YN3wPDuv7RGcE2Ji11yIM/k?=
 =?us-ascii?Q?wwluqif3gmoj6B2zpQHOLSHeoOYJ0pb/ESEcEzrFLyPsmmcyg43pXQW2BY9A?=
 =?us-ascii?Q?o8af6OadvOlki/u+H3NvHDv/KuN5DkAjL7ZHoOHM7jKLLU3SAyt4CpSvnSD0?=
 =?us-ascii?Q?k6gxCyfYlSYKMs1FJR6xa1r1Csf3WZF0R7RDhO5a39PBoxFzB06jhkCZr5dM?=
 =?us-ascii?Q?NESDeus4f4/H8fvYlULtwZrwsxcy4U/6Yb3NB3aGeEmzJKxYXf5VGm4af8k4?=
 =?us-ascii?Q?y7Z9SgMMNp2nrrtKoNzkz495jgh3aMPV94903hXSTLjbNzUXssWz56ugWfYs?=
 =?us-ascii?Q?OYXWfIYzzt27RgvFrfHet4Ad0K5pRjEThTeVeg/6oz+DUn8iIQl7yM10ZCnI?=
 =?us-ascii?Q?zBHYRU1pNzNr91GE1ZqSbUEZLYwWNof/tsv9U5+F+C83Jq9X0aDLd5nKYDiq?=
 =?us-ascii?Q?mdfWC1C+PsP5nPAWhDWIWoUhDRX1uYZO?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ozhvmR3XQaXeYZNHIS54q68fn6NJf4p7VHVh4HQPGofWhtnt18actu2RzVxQ?=
 =?us-ascii?Q?HXT3GwQJQdktJNnUc6WWBkbETBMvKGFXYPk9bl4zJMepXlf6HCaVC55t0nfV?=
 =?us-ascii?Q?hhNXXhp5si6fGn8HnsGvDLfzEeOvvUibeOVLGZUmzNC9dDMtu5Mf+o8wlJ1y?=
 =?us-ascii?Q?+Ii1EciHSd7ki+GV/jk4bG406kRtPiiNdIINXgUWoxiFFVgxXJH3HxsSnLZD?=
 =?us-ascii?Q?WeJaA+A74YFq7iD6djpzWYmIPmy7fvvKuqqB+e4bt0EJJz4lwnwLlYhJ5k/q?=
 =?us-ascii?Q?2WVcVLqwOPb2wL1qlrYCRyHwt/NwTpIw710x7qEs8OGL5Tm5ZA4Uw4YkBci2?=
 =?us-ascii?Q?YB3kW0k9qr2Su7xEdt3TYamtULTiMZTcC8XwTvp9C4hryOBzAykofYtIFOHC?=
 =?us-ascii?Q?VBQmC/CLfkrK8ywyhUDbOLO4WTe27fStO7cIwpbw3LWML+Lq6V+27GdeXNP/?=
 =?us-ascii?Q?BdlugsOl+kOUymmObRGiAPtvCBFVNwtKcETwM1Yb76F1dKq0IVA5NcypRneC?=
 =?us-ascii?Q?vCqVyOBsRsm2LkgtHY3prUYt8JDzWHl/CF3kiAiteHSFCH4akfnuJBWfplon?=
 =?us-ascii?Q?ON4OvBYBeIWD2ngt/l9t6tJnK9iE/p9A+Ys+rt8u657t0OipiakmI5bwyyuM?=
 =?us-ascii?Q?+5beoaSMsiPwrHzfT0Ikh6rlsSkCTQRr3b7MgSQnyWJ2YBmZketM8JO80HRj?=
 =?us-ascii?Q?quU4Ele1BqKXq4SL0Ki6rYcmjjOhgi57ugFgFnxpmDn+BuLMsdoVNUf80b2I?=
 =?us-ascii?Q?ow+PhWtcLWeW4mBuq9VX+zdqCvWIXH7Q5EFw+0yXyT7LhQWsL9G0MrmJSN4C?=
 =?us-ascii?Q?W8D+Wi37DPMp/EWPEnxnfPtMqcyUz2mZSAMhfHhNeJTsU3GZ6Gq54JyNchIh?=
 =?us-ascii?Q?IIq1i5iw4GCNhyHNnrhE0JIGh3SMeXDUbyG7+K7ywbQc1XL5tk8WOEVmwpwJ?=
 =?us-ascii?Q?zFKxhPPRi4IENgfBdWeS7RS3R6kplBPPmFEziXH8PA1C5ZzE5feyWXzPS9TZ?=
 =?us-ascii?Q?/Q2q7pPEbTz2j9hAlZUd8xLuikk7cncNXMjjedHdK37wgnImV3X5ugdWrU3N?=
 =?us-ascii?Q?6RyBNYbSuxtLLa4QStyJuv57XDHfY781a/8TqP7trGYhmw5fGwplaGXL/jvP?=
 =?us-ascii?Q?c3bj6uIuVH3E4cQaJRlXx7HCvOasSCIwXdTaeWfDMzbkOqbyNq/TrWjieaXm?=
 =?us-ascii?Q?NP/i15CyRGMIy1z3gUzXzUWNc3UsrOAHYll2wXWquqcwZtmpmCk+EoG2pYy4?=
 =?us-ascii?Q?rzBKQr4TJHmwc3tUIFem+5bigHPHWI96zw7UvNfr/Dl5AdhU7oxqN4esGBV2?=
 =?us-ascii?Q?fIdm+DkBt7y+NC9aW2C91eNNgIyxCKT2RyT1sFw3oRZHSFgGzHGEbLtY6WRR?=
 =?us-ascii?Q?b3z1OEuLV8nvCFGCmp7DHKHDTPH6joaERoN+JsxSkw6GC1yIJEVmBJSA6SDn?=
 =?us-ascii?Q?xlHXcNAOmYRPI1dXZqbOpJ2/soIJLjmTdSVbISTuklDnntTmrmsuWRfKq21Q?=
 =?us-ascii?Q?Pg5qPb4BAUBxXYSBlNSBXebQ3cEaTvesd/l4maUKkQCTDpX3tgtfzP1Y/lhx?=
 =?us-ascii?Q?6tf9kpNOdJcitU1/EsMVCtnMUY5DRXwFY+NezWjRZUz3GCghG9KUNrbqYARm?=
 =?us-ascii?Q?BA/nm6YbC/CfVKubQhItMhvHw0w/9Nn4a6QCJwf7cSnRNuXiVT15rdIBhCGK?=
 =?us-ascii?Q?Z0Rzi3zUBHpye9+5v2JAhWFHv5k3xtS1pGjzELvSbJYWfWu2KqGUDJfDaeAL?=
 =?us-ascii?Q?kYPEwXvuAg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 366088d4-fa3e-41b9-c76b-08de3f50455d
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2025 22:45:12.9001
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sxZwRy7SXd/V3RDEaJALNwYfr4I2By4x9oC4q6VtrlUgZuCa983z3IZC7CotljtOV+hIB/H7Or26dDHQpB8G4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9421

Currently, ops.dequeue() is only invoked when tasks are still owned by the
BPF scheduler (i.e., not yet dispatched to any DSQ). However, BPF
schedulers may need to track task ownership transitions reliably.

The issue is that once a task is dispatched, the BPF scheduler loses
visibility of when the task leaves its ownership. This makes it impossible
to maintain accurate accounting (e.g., per-DSQ queued runtime sums) or
properly track task lifecycle events.

This fixes the semantics of ops.dequeue() to ensure that every
ops.enqueue() is properly balanced by a corresponding ops.dequeue() call.

With this, a task is considered "enqueued" from the moment ops.enqueue() is
called until it either:
1. Gets dispatched (moved to a local DSQ for execution) or,
2. Is removed from the scheduler (e.g., blocks, or properties like CPU
   affinity or priority are changed)

When either happens, ops.dequeue() is invoked, ensuring reliable 1:1
pairing between enqueue and dequeue operations.

This allows BPF schedulers to reliably track task ownership and maintain
accurate accounting.

Andrea Righi (2):
      sched_ext: Fix ops.dequeue() semantics
      selftests/sched_ext: Add test to validate ops.dequeue()

 Documentation/scheduler/sched-ext.rst           |  22 +++
 include/linux/sched/ext.h                       |   1 +
 kernel/sched/ext.c                              |  27 +++-
 tools/testing/selftests/sched_ext/Makefile      |   1 +
 tools/testing/selftests/sched_ext/dequeue.bpf.c | 139 +++++++++++++++++++
 tools/testing/selftests/sched_ext/dequeue.c     | 172 ++++++++++++++++++++++++
 6 files changed, 361 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/sched_ext/dequeue.bpf.c
 create mode 100644 tools/testing/selftests/sched_ext/dequeue.c
