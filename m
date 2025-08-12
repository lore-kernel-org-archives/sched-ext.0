Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2055.outbound.protection.outlook.com [40.107.96.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13AC27FB2E
	for <sched-ext@lists.linux.dev>; Tue, 12 Aug 2025 13:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755005545; cv=fail; b=XkKWWe4lCGIKamGiUD8Uko/gjMqPgpa+cKL9R5HhLJizkeervXi9iJk3YUmeR6WSDkyMz3jF0s5fdgxgMVqv60dvTolEotey69YzWRiuWw7N9EVAGxhO792snMTvacGw2PJx8YdbavJK/JfjbEBcb5249rgCdjtx4iip3T+Aaqk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755005545; c=relaxed/simple;
	bh=svikDL6zg+QNq0gs2tiOmz1zT4cKIV08fKt00S9AxYM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eolZAXc2zXU03P7vVI6N/fBOopAkquJYXWa+3B+dpSUZAEnEKcggKKfwckjb/0b3ceii3xFUYY7jEBTm97VdAtF2JmyWMHsJ8N76evSdWcH5lkZqo7KYKlFcfAOKsqtGgd9o2vdGugikFCnV/9UPBgu/Qd5FwfZS5fsygWkbX3g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=F2uhYkOV; arc=fail smtp.client-ip=40.107.96.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="F2uhYkOV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yX/9ewze5ZfiTTt8blEBV3yTfKyXX8eaPh7FmGaLax3dgFYFjDkdgppMTCTJVuPlVJD4CSst6xF9pN9Jh+BV0Y6K7yuxEJhOUL6o48qQpY68kb8/B9Q+FdKAMSIPJXc5cSEo/1XFobRROq9LcqB3Xb+PpGBKrBK8xPxwzmX6USgGwgKyN5LFvnQOwRV/3VT/kSTqW1HH2Lm1PyugR+N/CrrAI3Fudw72/k6vVKTb+Jt5RDCpFAyWBvhuC5mqXIZTgK59NFv4J+40E2Dl+zhl29CO3POcRRW8QeEAy6gIg3s9th0JldqMo7qJTxR/do+z66wVYwVUsJhEBhv8QCPrYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=clrkIKXV/imbydNkdIlDxQqmOgeEoRcbfhRfVHswdeo=;
 b=tfGd9ohJFaUz5PQQbUfrS5C+yEwjzBf8fQOjnW4q0a0b0quqSPyaDHmM5Sx0u9prReI6Uj2odneR+rm+Pe+KqNVgaTRc5WpNLbxwf0eZhTpUcioHchXlqk9qrfDoH8cKrLIZHgzSSw+AZVWWYfFLhLAL16KFruaYcD6GUXfCAsiwDhbH0LXurX4Mkht8LjZFPDrOXtVW7DIkyWSr6xal81WTXavUYmG9YOpF7FtVwmwcj5U64hPqiJQAJEUpOp5sZpXAod05CCARLSTYsT/AGwQ5k97XBL8bmlTCV1b9KWcoc2+pR0wvryD+W8WS4+WtxE0/+Ln8Ywz3cHS8XGcHyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=clrkIKXV/imbydNkdIlDxQqmOgeEoRcbfhRfVHswdeo=;
 b=F2uhYkOVBl0vY8An4di2kUWq0cLt6c+aEyAt9MggqSkzC/ac3EicHv+0FgQJS6xY4R4TJhqY4S7aksjypKrW2doN5A2vTg6w0Z60IPHZ2DT+jqpo+jWBCK7ZhhKd5nbs3QIyEGpJIGZVTSDC8DBOqe+NNDuT4zCQMRPuj1uulTS5nM0e9J5J4BDVa+ruj+M05St/WU91z79ECwWuPcubpjnTBrTcGha4RapILwIQ0FmrwHc6AAMBp8vCOY7dJnAWYBuXYvT/8a/yq+39Wpku60cEH87uxdnx2pM5wwMGIlFbyZzgkRJeC1dq8UEP+fo7iSYb5FDQT6Lmo4HmGzbAig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DS0PR12MB7926.namprd12.prod.outlook.com (2603:10b6:8:14a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.14; Tue, 12 Aug
 2025 13:32:17 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%5]) with mapi id 15.20.9009.018; Tue, 12 Aug 2025
 13:32:17 +0000
Date: Tue, 12 Aug 2025 15:31:54 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Jake Hillion <jake@hillion.co.uk>
Cc: Tejun Heo <tj@kernel.org>, Christian Loehle <christian.loehle@arm.com>,
	void@manifault.com, linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev, changwoo@igalia.com, hodgesd@meta.com,
	mingo@redhat.com, peterz@infradead.org
Subject: Re: [PATCH v3 3/3] sched_ext: Guarantee rq lock on scx_bpf_cpu_rq()
Message-ID: <aJtCSjsCEtN1csjg@gpd4>
References: <20250805111036.130121-1-christian.loehle@arm.com>
 <20250805111036.130121-4-christian.loehle@arm.com>
 <aJebkj-neVJNKEJ4@slm.duckdns.org>
 <aJh6BWX7rYCNrzGu@gpd4>
 <y23etey3foin5nrxgj6e4g373b3ap6oxqa5rrvuvwyus3umw5s@bgh3d6uuga5t>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <y23etey3foin5nrxgj6e4g373b3ap6oxqa5rrvuvwyus3umw5s@bgh3d6uuga5t>
X-ClientProxiedBy: SI2PR04CA0002.apcprd04.prod.outlook.com
 (2603:1096:4:197::17) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DS0PR12MB7926:EE_
X-MS-Office365-Filtering-Correlation-Id: c7ba0402-07f2-48d7-ba5c-08ddd9a4a7dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?h+OVPjgXTDuOVYlTMKnpzPnfIZ59fg+OXCG+f7wbriLfwFxsk6rvSo1Es7s4?=
 =?us-ascii?Q?h9XtcTwPP9DHro4xKl1UfT8WbpANSHsl2X9U7WYR5iYiBegyYlj3takvgXDn?=
 =?us-ascii?Q?4QCUV1tKxEvV1gI1z57BwhmIMeyzSuPEkBSR/B9Su9hfPexA/mjhlWtSuxnS?=
 =?us-ascii?Q?nOS+cSDpBjQwSg1EaoOxGLO0nWZecRHR5EYxY4F8PHpmFeNvpXu81fwxY5CL?=
 =?us-ascii?Q?+JpiQyJ5M/YHsI3AlTLXrmzjAr80SPchSa0abvWL25gQ+gFPLqNJkHZxSZmr?=
 =?us-ascii?Q?qI1SKa7bjSmNEy+W/Stek659DTG1R5Qqviqm+R5gmrUiXqJhHuNv6/yFry2a?=
 =?us-ascii?Q?STLkvWg7jSvdqhzIRPOHJeCeanLLrXHidolubLN8GBkUj+qLTY087GMmAz/0?=
 =?us-ascii?Q?X387FfFUP41l6U0ah5H77vpl34htZYYO0YAVlqmpq3i3f0cVBw5jwC93Auj3?=
 =?us-ascii?Q?sw5/8sm6KlLR0RKAd28FQExxzNsmIVophJgA0d7+fwVYMxyYQt0BOAdFlCqY?=
 =?us-ascii?Q?aTHF8mEVf2jwW3v+nVa3qxtAgmTPqYbxjI47vVHYoH22BSbm6+IrAaLKs7Ea?=
 =?us-ascii?Q?A3EOPcLdnRav2tOnyAkwMQPlM4gxfFHAr5dzwtYy6UZ6liA0Strt3zTZ3nmD?=
 =?us-ascii?Q?/LaotJ3Z+2OtQ2/wAwADeoH5oCks7ngjEmEBwu5AH9HrBppbk72PeDxDlY8K?=
 =?us-ascii?Q?0DD9kNqSuXLjGKaF1n2ZsrB+iKWw9ozN5pfWTbPOh8L8W3qR02zRCxbFYxZj?=
 =?us-ascii?Q?PngXxHCDRMzgIH9mGvpMJngBwbCz8itHjuvY3VDUjlEn5aiwGPuXHJ/dktct?=
 =?us-ascii?Q?9fjfIOVUBpO5VDPmAFng4pIWU+EjexK6X0T06L66HMmblSP1ba4bKtG/q37P?=
 =?us-ascii?Q?QT1g2rFGeTSlrRPjuU2TH/CsPyNVZu+2lZyYo9IalnRSsItjyK6v6MgLl0+1?=
 =?us-ascii?Q?4l3ZZDS0/Q1dNDmcDJFfK7ClEFE6liAQLyrgVuy80ybdK3JqwQUYBMP9Igfz?=
 =?us-ascii?Q?SZVOigVeTHdP5dBMKfXwQOBMwjvTkavHHDrvqZ4/sdVmP7mX7ImMPcAcV8fU?=
 =?us-ascii?Q?uqegItvlIr/jvNub/emU7OJtwqgV6HNXxB6N0SX1yVidQbq4qUUPr+JQGwW2?=
 =?us-ascii?Q?4gFpCeh9/S8xVE5vvSMjSpOOPlwMB15y5ZzgOkZXCL/xhxxFZRoz4VdTlX43?=
 =?us-ascii?Q?pJDFu5wQgdX0Sq5Lrbvy/PG27qVq1p+vV2LNymfAx2RIhFXkrkJS2GsfSUS7?=
 =?us-ascii?Q?uD9RFoysoxCHp6JuH9pdQ577WHqqOeb+dTWhqGwdqvODinmJ3ascR2K+bORB?=
 =?us-ascii?Q?Zqifm7ZDiruWvbbh7a9nGOzSpBU3OVSrpOIkFCxVlJJWF3R/HE6UopY80FXK?=
 =?us-ascii?Q?I/KYN60z7P25sDhRbCaBm8M7J2EmF6KgDfq5+4TDygiEOzcr6A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NadIUrRqIT8WClThqC2YvCQ/xrgb9G70kHeqfjKwisxZsuVGZMyqFjhuXemc?=
 =?us-ascii?Q?oG/n9Nkp9EhVaadDZy3/5j+tjZgUfx3f+40Zpn8UjnHgRJkmOgLqeaRp22Cb?=
 =?us-ascii?Q?VDzjFfBC2LCmLys4gt2s+yHkYfXsAkjVv2QQMoFEzeo0bS0OcgGr/jeN9eQm?=
 =?us-ascii?Q?BvVKn37yeAC+cIxhiCZ4vfD/iESeaeO3lWvBZU/ZnuIXQ8WPcD3ja3JKWHPf?=
 =?us-ascii?Q?wqPe2U65WdZk5KENNje3vbA/qNRF+o0L9kcOA93TRAJUn54FQm4UedU1wknv?=
 =?us-ascii?Q?O3GZFbxi4/gQjwKcT3iToIdq+q0JxW1sLmsWkmo9zWb2FXr6t4xHo5wAY2Dg?=
 =?us-ascii?Q?3qCtYuLbiMCJTrXPZhcGHnapIOmfXy0KpO5dwhX8jORs9bcAE/g9GDrTND0M?=
 =?us-ascii?Q?Tr/heWkZ5WvAbK12emniHgHCKXB65LiIyCR1q/gec4LzoAz4GmdbhYT0jIMd?=
 =?us-ascii?Q?H/BFjtwuOjbxsXxp8rBkW1ZtHMG8VScw3x8DkyJv9DotW8EhJ8JNXM+Ox2E4?=
 =?us-ascii?Q?cDkuLaUkAvW1s517QetKnfhh6JsLcceLu5f13amsw/uKoa8Hu/ixhoavROnE?=
 =?us-ascii?Q?lFZ0rjzuIdJO1he90visQPGQBA4UYjxrUVWxOO2iDMr1K2ri3sTKbDMmo1e9?=
 =?us-ascii?Q?VbSH+wLrsiLVE8bJYzzPeAsUU4zEEW6hreAI0Ec85fI6eLzyk1d0OqH2WKdQ?=
 =?us-ascii?Q?B1MZ0VZNjX0dGaExzosTSSNeKLqbnwExXmPTOv9OxTwNvNwwgFT52yGxouLd?=
 =?us-ascii?Q?vO3jiOMndu2QfmJkWnYUnLckFoB9X5H8Ieb5V3/F0IwnkjzA6Kj2uMYQmZa4?=
 =?us-ascii?Q?5Q6aFa4qbQ+LnGJg7tOZ9mTDEhfXC5CmjWfYWVSL5o5YxFXyaMqdxnAmg7uU?=
 =?us-ascii?Q?XoBpmSfGponqEHddxLU8P6DPgSCepPBOFDcFkbFIQ0IuNVPYXIkcUdRyU1c2?=
 =?us-ascii?Q?gWudsH5fHBYLOualYb330ad3UawHseu6YqQ/HYdccGnw69pQamLkrCLR5dfN?=
 =?us-ascii?Q?XtyAIz1xfXG/JqlOVUsOhVnWM9pyDZJ8WFirqQsFQxQPvmiSBSFSPmAK3mT2?=
 =?us-ascii?Q?2TRwInwmDwySPyJoDu6Sik39GtFS0kkHnUW3zZoAdYarU6f80iqa41QwohFQ?=
 =?us-ascii?Q?l2x/MFKBYQUPn0FJhooPpV0bVLQLVCTYAz0icp21TjAz+6PpbZ4BDIQyBdEp?=
 =?us-ascii?Q?TX/mF9D5BS1oVbgM26FR9bYfIEXTwHzH+8f8h9und5kY9AbTm2ElwI/bWytd?=
 =?us-ascii?Q?hwTbDAsxXO0yZb61ki1gOoJT/gFO3CKdELh8B8FqFwGokmJqLjSY3LuMJyYg?=
 =?us-ascii?Q?mjgZCyLdI/iecjxLvCtkLtse2Q4J+OFDM2VCwC/zUC6lIyF/vZ9LzSlUvCNs?=
 =?us-ascii?Q?lhV8jpS2oAD20IrHNG6X2WSP4fOJgIUKU+iuZjO9U6U9dRh9NfwLVC7dntQu?=
 =?us-ascii?Q?RykxiNosctSwuTEqvH4ooPK2UTA2Fmo41oTLcQmyUurOmvLmVpDkwNCHyMhk?=
 =?us-ascii?Q?JfaClbVh+4tVmDEtmrADcPzWcOEhpKyMnZpVmlZ3cRHMmRjkuoBeMsCtobCp?=
 =?us-ascii?Q?XT2PgrJO2Rh/WUL1Wv2LdmXbcjIc/gC68EdxC0Pf?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7ba0402-07f2-48d7-ba5c-08ddd9a4a7dc
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 13:32:17.5459
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yx2mKu3ULxoJU8Axr8ky7Ke3P7yh4I38NRptrf3yrqZoe5NsPChgSbGYaQxxrRawRZwyTWleRWtcnKbdsXxY2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7926

On Mon, Aug 11, 2025 at 03:35:05PM +0100, Jake Hillion wrote:
> On Sun, Aug 10, 2025 at 12:52:53PM +0200, Andrea Righi wrote:
> > Yeah, this is not nice, but they would be still broken though, in PATCH 1/3
> > we force schedulers to check for NULL and, if they don't, the verifier
> > won't be happy, so this already breaks existing binaries.
> 
> I ran some testing on the sched_ext for-next branch, and scx_cosmos is
> breaking in cosmos_init including the latest changes. I believe it kicks
> off a timer in init, which indirectly calls
> `scx_bpf_cpu_rq(cpu)->curr->flags & PF_IDLE`. This should be NULL
> checked, but old binaries breaking is pretty inconvenient for new users.
> 
> As Andrea says, this is the already merged patch triggering this.

We should provide a compat helper in common.bpf.h and fix the schedulers to
use this helper. Something like the following (untested):

static inline struct task_struct *
__COMPAT_scx_bpf_task_acquire_remote_curr(s32 cpu)
{
	struct rq *rq;

	if (bpf_ksym_exists(scx_bpf_task_acquire_remote_curr)
		return scx_bpf_task_acquire_remote_curr(cpu);

	rq = scx_bpf_cpu_rq(cpu);

	return rq ? rq->curr : NULL;
}

Then we can drop this after a couple of kernel releases (like in v6.20).

-Andrea
