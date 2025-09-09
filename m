Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2059.outbound.protection.outlook.com [40.107.244.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE8435E4E8
	for <sched-ext@lists.linux.dev>; Tue,  9 Sep 2025 20:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757450709; cv=fail; b=Q0Ed/5xhNRSmSxqxq7mxF3xNFO8vZxu3K1oR9eZwLj1FWByGO03l8fkeu17fI50oRRfdGYt3wz82my9j3AUTnSdheg2xyc7ahyolYO1eVR1LsQRDt1R1C1sLPGjkhiXmO2ISiR5r4BUpgUvHTkxPUVdZCJbh4alr2IZjknyYgKU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757450709; c=relaxed/simple;
	bh=Ypk/jYS3fkIdwDKPXTWMBLnxgvBqvBqC0AuFlgRgBa0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jhQ6WrHXKHYOpkyREqA8lrZGTy2aUdGW6RwahARk9KFSeuqo4tGNbsFZIIqxlkuLoGCTB2xsb3rBsYBEsAX/y7ClupkUyymNQaK+pwgfcGl9F5393wjKNCNkeLey2LjOr45cfOWiNKOq8QaWX3yAkxJJB5F8wV47fxblqTIQqEU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gVym0zHD; arc=fail smtp.client-ip=40.107.244.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gVym0zHD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=upiOl5Qpg/MkpEctkFjLjqi5GJqoGjHanQDvaCZt9ECoRVJEwQj7+Ew8wh2lagBm+KF6WaaqdQFEJcU/LwgLDplVTX2XDUxpdw7s5IR6h3l5BgXWRdOfHhi4BLjzSsbN8xd2wZcq4yGGh7r1beo0ga96PvQf8m++vjWmJuG/XQMoQu5w4ZovUtOxea2qzTZrsyQC8MC4iOPWIuBaucWCWSBLVsQq2EIPHwVaw7MkUYbmVUJRydgfYalppO/Z4xtrMtChIW4/56Wd2fubu3Hlv4DMJff/WvRk5KPbgXJRcsC3sodqTJQM2vPCDOwwpc6utG/82QX4fWOfegOPFFUldg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jriQu9I2rXuMDTAwo7im/ypIfaMxN6/XgLrf3EX6Nec=;
 b=YKnfzUzT+JCGXN793ocqO9yKaCQxN9eN0SKqgKxbEm+ZxTE6TKCbR4Y+POCuIRrF6LFUAOoy/RFFafwMA+x3rIFV2jb+Z+M+Z4a6UarNK8pGb7gHxFe2R1SCd9dsaom6F4+VI2I0q/YM/T4qzcaghBONVEHf9ATQ3yXU0zmYxpln93p3mqlXBFZtxBM+la7gzyk9md5iSlCG8RnK6rxea9PDI7wtZyeiWxbeTtHHC/TPJ4X+AHjKjpQ/gl7nBD4Rb5eMxJCfPfLUacwkmchPYnHu/UcDWAyZFRNMRodlJmTGGgJ5kg15B++Sfx+88IDWmvMw34CDqgpFov45+R+yTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jriQu9I2rXuMDTAwo7im/ypIfaMxN6/XgLrf3EX6Nec=;
 b=gVym0zHDEmIMAo1PGDPNql1z4FfQ6g9Uo/+BPoR57zC6yb12PKqmsH77XUWDEAEsV9lyBUIYWjCP9OYIq7uZztQVrwy+IWMPGmOCYp4pZc3vAE2kAakzLLsCqd6UqZ+TGre0QNwh6lllA2lBvUlT2+tA1ZN/FZSRGJcrxKmLgJS6UUKP2bcqNbeZwRZTJKoFTuAB1+2chyjKfsP+7+9JNpvhOOvBArYz5Bmi0NRL8e/fOj3Ini2gzk3QLfnugkvRg7eLg/2A0tZqczAVbhMJ8oR3XFSIcWve/yA/rRlzFT8HSan6VUDPT1no8n+YoUNJ/AqZClns50XLmDSeZE0RDA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA0PPF64A94D5DF.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bd0) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 20:45:04 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%5]) with mapi id 15.20.9094.021; Tue, 9 Sep 2025
 20:45:04 +0000
Date: Tue, 9 Sep 2025 22:45:01 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	Christian Loehle <christian.loehle@arm.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-6.18] sched_ext: Acquire task reference in
 scx_bpf_cpu_curr()
Message-ID: <aMCRzXgDv6PGqLwp@gpd4>
References: <20250909195709.92669-1-arighi@nvidia.com>
 <aMCHjFwwjqvKsZBg@slm.duckdns.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMCHjFwwjqvKsZBg@slm.duckdns.org>
X-ClientProxiedBy: MI2P293CA0008.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::19) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA0PPF64A94D5DF:EE_
X-MS-Office365-Filtering-Correlation-Id: 2eba28dd-9435-499c-fea0-08ddefe1c135
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vPcUquEEEu7L6PDQ9DxieWeBGvInmfscYsiUdmxorx4IZPti8uyBSV8vla6a?=
 =?us-ascii?Q?rR+1OU/qtAwnD5H9GQBLOqewxrMNBqzPpsqEa7t4azc5A2a5AwcoMQs74niZ?=
 =?us-ascii?Q?p6eEHB9Os9HiiR/4liZ09dGRbRMOs3wElVLVWD9D8QXZJgLY85LExtX1av+j?=
 =?us-ascii?Q?4czCXdbcepNSvvUD71Zl79vSiZfRYDrUJnVbUdQeoGDdJXssERd3DsLWBI5W?=
 =?us-ascii?Q?QWQFzOhARZju6WwPXWWXAFoC+w77Jm4nszX2LvCweAbqQPTU5Qa4irNpmGuM?=
 =?us-ascii?Q?knNR/JftBK5C6xg44q8e2f0Z+puajLIPJcC24xBQY5KlIZtjOZ2dThjHmJb0?=
 =?us-ascii?Q?xrSTDtKL4ZMFIQ+nh9nerisr5X2cYDtuWs9kNTc2gGZtI6VxMkIwIOOTwF25?=
 =?us-ascii?Q?VQ4YSe/3OMOoUb/XzQjz0aOAciPOnH8Iz9SLR6hZBrvsxExDCua81cL8Jlno?=
 =?us-ascii?Q?tGAjWjPIpEsfLl/6n+yDpjq4LaqkYtHycOteJxLdH0TOqmnoEhyua1YK+vD4?=
 =?us-ascii?Q?cEkeLNxYCe2zaNPVkCRu3AlVSQ4EIrtfIBXmIrkk40iI9XIX5+HdO+VNSIxm?=
 =?us-ascii?Q?qOQAQpftDO4IEn/VseZMhs6ahqWAhGOtmIsVui1U2moMYZCknZW4ZoH50qJe?=
 =?us-ascii?Q?IHt1a15qEZubk5rfcXSESzSqPMmGCKnXW/4RFhvKlSU7M2goq8Ixbe3AYaXM?=
 =?us-ascii?Q?p9c7JmnFuNMyTdbDExcHcqRL33aLJhmSioiM6KtjV6B9bQm4aS2Rb+MV5FQm?=
 =?us-ascii?Q?2avJehbavtOtxATio9i1+NX049D2c+quMN6UghudY/wTmwgHQFgnjN5hG4+J?=
 =?us-ascii?Q?gOSWCbLHZDU1FLSVoeYO1Q6uUIz7RVZw8S/Tx1G15YJAMi226ySCvm2MXooe?=
 =?us-ascii?Q?wZJS77PcQQZ/qEvlbs1qvzbeyGpsDa138Fh77L8gcEZpGRaE+nWN+47ka4mz?=
 =?us-ascii?Q?wj/LHXMaNsqWkS0SRW3a953OvIcTMCWo8E6KwyXUXGM0KYESpcEAgzE9dRZ6?=
 =?us-ascii?Q?V2oehsxr6NM2BZ+V1IYaQ0DNO9bAnCCIzBZTOkljDI8DkY5v9ZL80xdZBO7N?=
 =?us-ascii?Q?btQrxA2yTLHpVyIfxv6dlv46r4rkRvHRUOOf+yx/usJFz2raRox+StPqr6Zv?=
 =?us-ascii?Q?rTGoUKMw1EpyyRXx4DcuSTzFnyk+RfyofIhm66e2FOhJ4SCubIogqB1FeQdr?=
 =?us-ascii?Q?jxRBhF0pv6jY8MVilGIT7zO9PAtOjPWD0lLGlQ22WP3o8b8HMUt9QR2QmG0n?=
 =?us-ascii?Q?Fi62WayEKKvGvtEV+z4/zFjQ9M1lOT/H5Aegj++Pu+i9pGXiOHqL9o8SIYOC?=
 =?us-ascii?Q?29X0XJhZVe0IwwGng/uRyLqLscyRl6IdZJF6IJwyP+RADKg95RvGsX5JSSf+?=
 =?us-ascii?Q?gnwsZuLovR7IICSX3mD3gp+v047r2oUmngq3SlvU1q4SuL+u23KIaOVxtp/U?=
 =?us-ascii?Q?/Ftr/vU3wCI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kxyXrBj+ooA9TgbXN+/6e4NPivFP2DRNbe90HpKmTsz8q2pcb0NaMWAjcyBV?=
 =?us-ascii?Q?AA8868HL7cXvAQmsyWjSmFgGu1dGt2zdPXH1CMykXUwefNOc0dGqJmyiR1ik?=
 =?us-ascii?Q?A7E5PeQvdg3XetettyH3H7ng0MtIAOM1Jv0FZmDF6JC7H7W5aGBa2gxxdQtq?=
 =?us-ascii?Q?qAEvfW/qZ0qEa5OlZazUUCn/IIh+WSxdb6AXM52zIPhAnYDby45WU+8Ec+BI?=
 =?us-ascii?Q?PDHv+TASENUhhD7f7kuusYskgTCqN+CqlJsFj7Ibh53CmI/gcpMf0lcm3QmX?=
 =?us-ascii?Q?yJ65VCSki4knsXVpW0MZ2gkgPMr0f2inWUbDbSzh8mdJ/98Jx3ZlrL8/tysU?=
 =?us-ascii?Q?hLgV5zq/0TT+5SHcelqB7J7yGWullA6S+udseiXd8mMGNZ0wQQ/zxFr6fQKY?=
 =?us-ascii?Q?G6PCOrdDUdtxLOrq3ljloyJwIUCDqIoW+/hQb8adhpnqLKUJ/b6gsauyKbQc?=
 =?us-ascii?Q?Dr6lyjSw8L0Q1QPSw//FK/1Oa5r5PQVIJJlsxsim1Gbr6NfIi5FK+459trTY?=
 =?us-ascii?Q?vaUsuovsbZ2OGXmjP2P661FeXyH9v/GU6udV/w98PAl9Nczy8k9k6WCUxkep?=
 =?us-ascii?Q?OL7IzcJqFZw5rr2aZSKLv7OhVqWBPsJ/ONXioloHpl7BIxI4MhpTbKIgdxu6?=
 =?us-ascii?Q?wnm3xiqRrON+QZN5JLM9S5463vR0qgBwUkmGkl8aU0IIeRVgZljiMPRLwKiz?=
 =?us-ascii?Q?6mpN36QrjgM1JV5WGRnr3d9sv9GsLHJq7YR5rwLCA4AZllzWI8cVwDst1HUO?=
 =?us-ascii?Q?wi/04hVW6sW4OPeLSu/bgrtv+A1zOLrx892XQOLr1Qpi8QD9G0AVZ/ukCw1D?=
 =?us-ascii?Q?AbYLcpLJ4zqHdkev73jz6i9eY9ce3nJBraqxAdeaxjFcutJ4b/Q5hattC2J6?=
 =?us-ascii?Q?x4BnwQ6et5G5Ok/E8ZmZD3kWPBPnfq/AjflPt/cKxs+T357bvnBHV3piGUep?=
 =?us-ascii?Q?N/3FIxAIzGaWC0m4oiv5sXWKoNTPIhdnZFUcRPd9PcLji3fZ3cpa6lYA8F2M?=
 =?us-ascii?Q?4Z8yX+Gt6gZOmWMJwWwmFMuk+px339nyEJOvj/poOPg146ulaxBWTLwIpBsv?=
 =?us-ascii?Q?fZco510jx3COycO0SjYnCU3Z9rPRv6qshVZHyTAQIrvnB/QpExDxLibOOncd?=
 =?us-ascii?Q?JVVQlP4y/3ER9eb8cBjMPiRNsPaMxGjDJR/j/RE3V6SzNyUoBW7LF4xLpC3s?=
 =?us-ascii?Q?B9uHNQKoFwbVCXC9m9J88AT3yU0JYS+r6NcU29H1mnPICDs+YtnYO/22LOcm?=
 =?us-ascii?Q?jqVRd8nXjF4h73JdVUBzmCXtPZkKQ/P/4phohON5k6ym86xaVuo/8RkwGhAj?=
 =?us-ascii?Q?z6ENdgEhKQ1UQvGcnJmtoj07KKJxIrGLNuy9WnnymXN7WVk7TEpPnThFNvMD?=
 =?us-ascii?Q?ypZ2GgatzFvqrdAYnAwtCLtud3ivgH4IzZeSqRtZZESyV/mi4DPmgE0P+30o?=
 =?us-ascii?Q?3tY4SfRtIBu70OmXesR+346CjtEANqDZN/KBW+Ei46mOJYGr8IJQIkT0p586?=
 =?us-ascii?Q?xfNxsCO9k4xXxtavLny++OKwu+VCxCNFbW4pqdryZ1vRKUI2sVmKKLVydK6H?=
 =?us-ascii?Q?LR02ywN+of+RScJrBH9LbpuoPGqVrGXo8IT/XEQ+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2eba28dd-9435-499c-fea0-08ddefe1c135
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 20:45:04.6635
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OMQC1/ehBzZ4tw/BpRH9khF+7CaUUWFiPRtXOWbSUwfyoEa5bOcEHO1C/zUQri1wWVtuJnaFj3J7OfFL86o8Yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF64A94D5DF

Hi Tejun,

On Tue, Sep 09, 2025 at 10:01:16AM -1000, Tejun Heo wrote:
> Hello, Andrea.
> 
> On Tue, Sep 09, 2025 at 09:57:09PM +0200, Andrea Righi wrote:
> > scx_bpf_cpu_curr() has been introduced to retrieve the current task of a
> > given runqueue, allowing schedulers to interact with that task.
> > 
> > The kfunc assumes that it is always called in an RCU context, but this
> > is not always guaranteed and some BPF schedulers can trigger the
> > following warning:
> > 
> >   WARNING: suspicious RCU usage
> >   sched_ext: BPF scheduler "cosmos_1.0.2_gd0e71ca_x86_64_unknown_linux_gnu_debug" enabled
> >   6.17.0-rc1 #1-NixOS Not tainted
> >   -----------------------------
> >   kernel/sched/ext.c:6415 suspicious rcu_dereference_check() usage!
> > 
> > The correct behavior is to acquire a reference to the returned task, so
> > the scheduler can safely access it and then release it with
> > bpf_task_release().
> > 
> > Update the kfunc and the corresponding compatibility helper to implement
> > reference acquisition and prevent potential RCU warnings.
> 
> I think KF_RCU likely fits better for peeking kernel data structures than
> having to acquire/release them. Can you post the full backtrace? Is it being
> called from a sleepable bpf prog? Or is it that we just need to expand the
> rcu check scope to cover regular rcu, bh and sched? And, everything aside,
> if KF_RCU, should we be tripping on rcu_dereference() in the first place?

For the records, as discussed offline, we should be fine marking the kfunc
as KF_RCU_PROTECTED instead of acquiring the reference to the task.

Right now the kfunc is marked as KF_RCU, which is not really necessary,
because KF_RCU ensures the kfunc *arguments* are either RCU-protected or
trusted.

KF_RCU_PROTECTED, instead, should ensure that the kfunc is called inside an
RCU read-side critical section, that is what we need.

In this way the kfunc can safely return a pointer to the task and sleepable
BPF programs can wrap the call in a bpf_rcu_read_lock/unlock() section.
This should prevent the RCU warning while still letting schedulers safely
use the returned task.

I'll send a new patch with a proper fix.

Thanks,
-Andrea
