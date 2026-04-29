Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012054.outbound.protection.outlook.com [40.107.209.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2B4311954
	for <sched-ext@lists.linux.dev>; Wed, 29 Apr 2026 13:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777470840; cv=fail; b=uKeoUF8QtoR5Ve6+BSoEZ8mU0fh22pVRM6F2rOmwuYDLilb9Od7eCGh9uH16Mqwge853MCf27NMnZUw1YB1ZMEhg36wuoSAWIZLNQLKjpNq7fP1ygavzYlZE6RqYy52g4FxB3Rp72LuxA17/MO76K5Pz0UsZB857GAcOnk20SX8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777470840; c=relaxed/simple;
	bh=kpeQNKrOXqRbuCLT/MR6T+ACbB3tWc6KkaeJzztBvdc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WnqjgtXUkJHz+uz3Evj6AEnPNcrkb/Bkex+78awlrRn1pBjxJ/UJqZ2RYDKFbO+jDt+IlgTyy/RYIBE5aycdWYpNhe5+axmTQhYapctsbVs8OP1U0T5MI/wGubw5B+zXBu2Lf07MBe820fyfKkHlg2eE1tP+dijV+RGHVn2fKcg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IbAD1xkz; arc=fail smtp.client-ip=40.107.209.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IbAD1xkz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oOkgzNkGQT0qoVFNr8BY+gvHXoKdi+IJuy3MI0Fw/pt3DA1ek40IW+db/s7SapiA0LHE0TNKM6OznhCkl9sDWQk+WiP3JuvIBr2HeuV6xtx23eJc+Lgvka+oyxqEg1LdYlPqOYMWdIrvEIZdDV7M8pDDv0QzY/ujB10qCQ2mibjPtXM2MXeikL6MD5suudgAnwvNIGkwmLenygC44vfdq1s7suWmlnj78uPrivyFhqVh0v+KFKY18HeY3m1aN5I97H/q7bQ/wZMpOwgvZxnWBJTqKHuc9e8NUBZV4pFVtERrQUvFndTfF03ubzkwk2uDh09zTj52JjfjWIRBy9bwKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fShcebxTySN+vuA0l970irh2kULWmKaEf04mx5g1NtA=;
 b=BfGjeqSKhEIRj2c6cY/nKXFKZWaKVx+Gh5FrC8+xPxhgvt/erLczOHKMZ8M0wTOExBDO1oUY/qQ20DdNLJ0e7RemZQOtulSUfjDU/9PS+N1bp5mzzFRjuIlSJiwyQ4L7H88An7hoObKheLZMHfiDDx9Dqri28ZQo66JwIpFDmURuupcdfDbNh2w5zoEC9s+EnxdhlzdiuOzBHJ8dtNLopExau4FNjLDelk5gQrgI+lkgsRhzIMigpYFwLiHRHnDV4oOIRIa3WWVj8ui1t/UYz0xsprWx4RJh0r2wikhwJg9qpN1y1x+v6ATx7kFTemDjBrsd2rRVf/OVfePKeezCow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fShcebxTySN+vuA0l970irh2kULWmKaEf04mx5g1NtA=;
 b=IbAD1xkzOf5iwPnpwgw7QjyQRjpRltLCCRrKWuTQiuLXOltuVM5SaocX3Ix2kv+5Q2DkkqYlxmHr5rjDnsz8yH5znhFR+aRJyo8n+8sBUheFKxjjQI2FYV8WgZrAhFB8y9HWI+zqrVrLknp1oZRuOV+ElcXxpwYNg+i6QcCqx6FnYZMI+sNuvTGkwTi6qnKc8cWSgYPVYxT4eTiN7P6Myk0XI/7vpRbe3Xx9vG6U03BLIj8bV/A5HgHk++FbcpYc00olbVEEU87GVB6MRZIAdTbe7j8+eahEiA3bYGOz/9hhllmwf9RzFD7gxfgaN9T7CPXZJsld3eTGNwR7pmnNXw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SA1PR12MB9547.namprd12.prod.outlook.com (2603:10b6:806:45a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.15; Wed, 29 Apr
 2026 13:53:55 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9870.013; Wed, 29 Apr 2026
 13:53:54 +0000
Date: Wed, 29 Apr 2026 15:53:46 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Changwoo Min <changwoo@igalia.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	sched-ext@lists.linux.dev, Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Cheng-Yang Chou <yphbchou0911@gmail.com>
Subject: Re: [PATCH 16/17] tools/sched_ext: scx_qmap: Port to cid-form
 struct_ops
Message-ID: <afINanPdf7IoUmJp@gpd4>
References: <20260428203545.181052-1-tj@kernel.org>
 <20260428203545.181052-17-tj@kernel.org>
 <3faf06dd-1175-4690-b97f-bb4e0b30566e@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3faf06dd-1175-4690-b97f-bb4e0b30566e@igalia.com>
X-ClientProxiedBy: ZR1PEPF000077CF.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:918::406) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SA1PR12MB9547:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a2356c4-ec3b-493f-845a-08dea5f6c0a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	rNcHKgoM9HPiutMqKdg3Btik291xS+OgtvZALaGoDIth/TLYKjzOWSpTb/c4Pv8ZiuYUub65ddMfmzqaabZLmed9xrFMY0P+EeUMTPm00yY6qUaiWSRyWO/8gDkSz0EOSh31j2gTsP5VZds4RYkqGJA0M34X3/f18tjALjhyWOc1/+x2wMODZ+RmDk1otzLKovBjjQohoXW7QinqAQrIA4vaNPghjMMxNeJdehug+XMm95GameCLFduX55QBAHrAoBHZ1TWR65B1imvdStZeIlLC5Iou8uoYxs6o3eMrjT0+SyMfgz+2anu+NwJSPaHp9x49aHGBDK3Ch5mzCUM8Vr3sB28JTr+5Bp5vD0Ez4JbgFO7PnS2faMhl/UElUw3palR1iAh0ESupMxAzYsvIqYgLhgGTiDtarAvysV1DXOTPG/GIM987WXOhLfWMwlZMQum7GDpUEjy8VhaRSRmEaA0VHnpJ9t1OP0qG09JBZHQR3F9IEFPlt2znTYERSLdIKdkG2PzakFkZqZYp2JBhqQfeSTGhcdcXICCdCpx5C7la0JVdzpbr9VemYA22Bl2ZydwYRNzej2uEv/93/RT+ihmLrqg+maLJCqIR5/4UC9MWDwVVCX4ks8iDGgNXT3+MCSjbAFh4VhR/udVYyPsHNUrLlMaWBt3xut8M7DJiAK/unadSJnMrxZMN/mpZ7cNGbwvpvsjqBfqBVeV8CGOVIsUgHzl/loR9cwwUfkT7jF8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OE1yZUlFeXFmZ2dqR0gyd1VTU296RXlBaEhYOGtTUGJuZWNtTWpNVGV6Vm5h?=
 =?utf-8?B?cmMyTlZ4ZEJmU2V2Y1YyMWNySk40OVlRdnNPOGJ5Mm5iWHYwNjJBVUVCRGVM?=
 =?utf-8?B?VFdzbmxEazcwNzJkMkxldjFVZThiTGpQRGxMZHh4cFE5cTF1OHc1TTN2ZVlG?=
 =?utf-8?B?VWxLTVJtNFRrOE9RSmdvQ01wUTRPSzFDaTJ0TEhvRWd0a01lUW5qWjB2QWI0?=
 =?utf-8?B?U2pqNkZCYTR4TDlYK2I3Mmtqc1RRN0FCZzJYc3pxWVV2aXNxZHJianRrNVVC?=
 =?utf-8?B?M2hhU0JhNHlCSnJucVhhNTQvN1VRRm1lUEhXUW9qdjNjd1lDdVZ1b29rYlJL?=
 =?utf-8?B?M0JXRnJ1dkk5QmxkcGRNN2ZLNFFaMy9FKzk2WERsSHhiNElXVEFjN3dPUHEw?=
 =?utf-8?B?MWlqeExJcUtzZFpXZFVtTEQyVURIbHpTVkdJbzJFSXdKcG8vRlYvS3RlR1hZ?=
 =?utf-8?B?UVJ3S0pBM3l6UU41UEp3NGI5QVlrOWV6b3BVUy85ODU1NnhBbC9Dc010aEtw?=
 =?utf-8?B?VDhGaWRBSjBSczdFV0dKZTVCYU9UcmR0MXFyc3pkWDRKaVpaVlVVYnN6Rnpx?=
 =?utf-8?B?QjlIT2lXVXZRcVBWYWdIWVVSU0x5VWFtdjlBdmRvbVVzR0Q0RW85dTJhcDNQ?=
 =?utf-8?B?eUZiOGFja3RBNlN4VmxEWFZZcE9oU3I4ODkvUWJ3bVowUUk5S2ZjNEZOVHdk?=
 =?utf-8?B?Tm9FMVJKbCtzV3NUYkdVT2xrQVdxbW5RMFRjZy9UbVJoRmdkUGNUZVAxN09C?=
 =?utf-8?B?UlFhdGYyNUsyL3BOSXpNelMyM0NxbkNoeFVYcXdtM2VDUjlEOWR5SFNDUUxQ?=
 =?utf-8?B?Q0paa2EyU1ZLVlg0RytEbklHUS9GK2o3TkVlVm5QTnpDVUFGMzA2bWZMc09P?=
 =?utf-8?B?Wmg2N1pwTXRQYkJubklOZ3lxQTUyemF4TkZKa1NuY09tbC9uOWw4RG92STJS?=
 =?utf-8?B?VThGc2tsU0RUeGZod3E3UC9zOHhlRllaUUZIemZXVjF6S1RQZnhmcXZDNFgw?=
 =?utf-8?B?Nkd5YTIrUDRGVGdMdDJ4RkNtUFpMbmZiSzlTZ1BTazlTSHpVM2x0MmtvY050?=
 =?utf-8?B?RWIwV3dXVVlYc1ZkM0MxK3NLZzJYN3paWDRkekYzTHExMHY4OGZUNTcwd0xJ?=
 =?utf-8?B?eDkzb3dwTVcrcmRYekh6NGgwSEJlTTdOeWQwTytRdzVNYVRqckI2ejZOU1hJ?=
 =?utf-8?B?L2EyWkxXQXF3VGRZWWFtWUl4ZlZHdE1kNTZXVzRqTHZVbVFkS1dVMkZVWXFW?=
 =?utf-8?B?cSsyeThjSmpZUUJKWktaYzc1MjFsR2dQREN4REUxS0xoUHYwaUdwVUJHWTdN?=
 =?utf-8?B?Qmx3RU1kRU5jeXorMVVoaG5CRFVJdlpLSWVPQnRSS2FYZ0VWR3MvdTcvcEx4?=
 =?utf-8?B?dVlJMzBPait2OVFiSldiSkR3dGxyRitnWGtaNjQ0Z3J0cnovUWNHeDczSTJW?=
 =?utf-8?B?MUU2VUhJQlhLMFpKVExaWDhGV1F4cXpBb3lhVVUzWGtuaXVKYjZ1ZDluaVdh?=
 =?utf-8?B?U3c4NWEwUmZYb3dhMHpqN1JsQ1hRYmN3UW9BcFNWMEdIZ3NXSy9UMUN1TmQ3?=
 =?utf-8?B?OEVJVlYrRHFSbkM0YUlkU21Id0Z1dVpnRWdVcGxFckNVT2VPam04dk54Ly9G?=
 =?utf-8?B?TEdRcnJaMzlDZHo0b2lKMjVwc2lac3hNV0d3VnpLdHZPNnYxSjN3RElhT3Fj?=
 =?utf-8?B?N3lmR2dQMk9sSkV6MTRIendkSFIrc0kxMUpibXJ3LzRkVGZ0c3duZzVHZGVY?=
 =?utf-8?B?dEhKVVMyd0ViQ1E4ZW82eUtpa1hhRW5WSHJoQnNZTGl0TXhvTytMU0tkTUpX?=
 =?utf-8?B?QXBvVFM3ckVkOFpZQnc2MHRBMCtMdGtLZGdLRVdDb09NSnNSUUMwVE9GTlpl?=
 =?utf-8?B?cUhrUUxOQ2N2SzBxYy9GR1RTV3Qra3ZCcDlFV29ZQWg5L2xpdTVxTm9KbmZn?=
 =?utf-8?B?aDRGc2M4b2FENnc2THdEcnVUK3luWEw0MzAwRTkzeHpYUytkUmFVVEJhendl?=
 =?utf-8?B?YkRwWGRTRENzRG16d2FUdkhyVGZhcldyWCtUZTVaQmlJWW92RDVyTDQ0eDBq?=
 =?utf-8?B?ZkZUZzRIZFNpWSs5dkk2cndzdTV0SEt2NVJLRmk1S08ybXdSbldqUWRMMGR4?=
 =?utf-8?B?VTFlYjExVjdVY2l2MnUzWDVkSHFBcXdzcGNGUXVub2FMYktKVHV4aG9hWWpw?=
 =?utf-8?B?OWNYTndrbVBXS0hwWWxsdkI5eUVrQTZYWmE1d3lFcWRHN0JRNFVyVWNOdTdK?=
 =?utf-8?B?ZHdFTS9CRlczNmI0UWVFWnY2UjZteUVvbzVpQ25zOWxyUWRReVFrRVRSQWVw?=
 =?utf-8?B?TWkzSGc2NndQVSs3YzFHUU1nakpiVFBuQnZITGZENXhpMVVpUzhRdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a2356c4-ec3b-493f-845a-08dea5f6c0a1
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 13:53:54.7266
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6/l6Alyw6846b4Q+g31SrIwokd93qAUg7Y6F1ahnCsw7520g6paDjm+zsFYrPKhsEVt5YrUlIGWmwT8Lt17RpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9547

Hello,

On Wed, Apr 29, 2026 at 09:47:12PM +0900, Changwoo Min wrote:
> 
> On 4/29/26 5:35 AM, Tejun Heo wrote:
> > /* @@ -1083,6 +1082,18 @@s32·BPF_STRUCT_OPS_SLEEPABLE(qmap_init) › ›
> > return·-EINVAL; › } +› /*+› ·*·cid-
> > override·test·hook.·Must·run·before·anything·that·reads·the+›
> > ·*·cid·space·(scx_bpf_nr_cids,·cmask_init,·etc.).·On·invalid·input,+›
> > ·*·the·kfunc·calls·scx_error()·which·aborts·the·scheduler.+› ·*/+›
> > if·(cid_override_mode)·{+› ›
> > scx_bpf_cid_override((const·s32·*)cid_override_cpu_to_cid,+› › › ›
> > ·····cid_override_nr_cpus·*·sizeof(s32),+› › › ›
> > ·····(const·s32·*)cid_override_shard_start,+› › › ›
> > ·····cid_override_nr_shards·*·sizeof(s32));+› }+
> 
> This cause the following compilation error due to argument mismatch:
> 
> scx_qmap.bpf.c:1093:10: error: too many arguments to function call, expected
> 2, have 4
>  1091 |                 scx_bpf_cid_override((const s32
> *)cid_override_cpu_to_cid,
>       |                 ~~~~~~~~~~~~~~~~~~~~
> 
>  1092 |                                      cid_override_nr_cpus *
> sizeof(s32),
>  1093 |                                      (const s32
> *)cid_override_shard_start,
>       | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>  1094 |                                      cid_override_nr_shards *
> sizeof(s32));
>       | ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> /home/changwoo/ws-multics69/dev/linux-tj/tools/sched_ext/include/scx/compat.bpf.h:130:20:
> note:
>       'scx_bpf_cid_override' declared here
> 
>   130 | static inline void scx_bpf_cid_override(const s32 *cpu_to_cid, u32
> cpu_to_cid__sz)
>       |                    ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> The correct one should be as follows:
> 
> > scx_bpf_cid_override((const·s32·*)cid_override_cpu_to_cid,+› › › ›
> > ·····cid_override_nr_cpus * sizeof(s32));
> 
> Reviewed-by: Changwoo Min <changwoo@igalia.com>

And after fixing scx_bpf_cid_override() I'm also getting this with
`scx_qmap -C shuffle`:

0: R1=ctx() R10=fp0
; s32 BPF_STRUCT_OPS_SLEEPABLE(qmap_init) @ scx_qmap.bpf.c:1069
0: (b4) w1 = 0                        ; R1=0
; u32 nr_pages, key = 0, i; @ scx_qmap.bpf.c:1072
1: (63) *(u32 *)(r10 -4) = r1         ; R1=0 R10=fp0 fp-8=0000????
; if (scx_bpf_nr_cids() > SCX_QMAP_MAX_CPUS) { @ scx_qmap.bpf.c:1076
2: (85) call scx_bpf_nr_cids#110275   ; R0=scalar()
3: (a6) if w0 < 0x401 goto pc+14 18: R10=fp0 fp-8=0000pppp
; if (cid_override_mode) { @ scx_qmap.bpf.c:1087
18: (18) r1 = 0xffffc90000322260      ; R1=map_value(map=scx_qmap.rodata,ks=4,vs=964,imm=608)
20: (61) r1 = *(u32 *)(r1 +0)         ;
21: (05) goto pc+0
; scx_bpf_nr_cpu_ids() * (u32)sizeof(s32)); @ scx_qmap.bpf.c:1090
22: (85) call scx_bpf_nr_cpu_ids#110276       ; R0=scalar()
; if (bpf_ksym_exists(scx_bpf_cid_override___compat)) @ compat.bpf.h:132
23: (18) r1 = 0xffffffff81464430      ; R1=rdonly_mem(sz=0)
25: (15) if r1 == 0x0 goto pc+5       ; R1=rdonly_mem(sz=0)
; scx_bpf_nr_cpu_ids() * (u32)sizeof(s32)); @ scx_qmap.bpf.c:1090
26: (64) w0 <<= 2                     ; R0=scalar(smin=0,smax=umax=umax32=0xfffffffc,smax32=0x7ffffffc,var_off=(0x0; 0xfffffffc))
; return scx_bpf_cid_override___compat(cpu_to_cid, cpu_to_cid__sz); @ compat.bpf.h:133
27: (18) r1 = 0xffffc90001526000      ; R1=map_value(map=scx_qmap.bss,ks=4,vs=4128)
29: (bc) w2 = w0                      ; R0=scalar(id=2,smin=0,smax=umax=umax32=0xfffffffc,smax32=0x7ffffffc,var_off=(0x0; 0xfffffffc)) R2=scalar(id=2,smin=0,smax=umax=umax32=0xfffffffc,smax32=0x7ffffffc,var_off=(0x0; 0xfffffffc))
30: (85) call scx_bpf_cid_override#110197
R2 unbounded memory access, use 'var &= const' or 'if (var < const)'
arg#0 arg#1 memory, len pair leads to invalid memory access
processed 28 insns (limit 1000000) max_states_per_insn 0 total_states 2 peak_states 2 mark_read 0

The following seems to fix everything for me.

Thanks,
-Andrea

 tools/sched_ext/scx_qmap.bpf.c | 26 +++++++++++++++++---------
 tools/sched_ext/scx_qmap.c     | 16 ++--------------
 2 files changed, 19 insertions(+), 23 deletions(-)

diff --git a/tools/sched_ext/scx_qmap.bpf.c b/tools/sched_ext/scx_qmap.bpf.c
index f55192c7c51aa..800a92fdb6db7 100644
--- a/tools/sched_ext/scx_qmap.bpf.c
+++ b/tools/sched_ext/scx_qmap.bpf.c
@@ -63,8 +63,6 @@ const volatile u32 max_tasks;
  *   3 = invalid: non-monotonic shard_start
  */
 const volatile u32 cid_override_mode;
-const volatile u32 cid_override_nr_cpus;
-const volatile u32 cid_override_nr_shards;
 /*
  * Arrays live in bss (writable) because scx_bpf_cid_override()'s BPF
  * verifier signature treats its len-paired pointer as read/write - rodata
@@ -72,7 +70,6 @@ const volatile u32 cid_override_nr_shards;
  * them before SCX_OPS_LOAD, same as rodata, and nothing writes them after.
  */
 s32 cid_override_cpu_to_cid[SCX_QMAP_MAX_CPUS];
-s32 cid_override_shard_start[SCX_QMAP_MAX_CPUS];
 
 UEI_DEFINE(uei);
 
@@ -1073,12 +1070,25 @@ s32 BPF_STRUCT_OPS_SLEEPABLE(qmap_init)
 {
 	u8 __arena *slab;
 	u32 nr_pages, key = 0, i;
+	u32 nr_cids, nr_cpu_ids;
 	struct bpf_timer *timer;
 	s32 ret;
 
-	if (scx_bpf_nr_cids() > SCX_QMAP_MAX_CPUS) {
+	nr_cids = scx_bpf_nr_cids();
+	nr_cpu_ids = scx_bpf_nr_cpu_ids();
+
+	/*
+	 * Separate compares so the verifier tracks each upper bound; needed for
+	 * scx_bpf_cid_override(ptr, nr_cpu_ids * sizeof(s32)) vs bss array size.
+	 */
+	if (nr_cids > SCX_QMAP_MAX_CPUS) {
 		scx_bpf_error("nr_cids=%u exceeds SCX_QMAP_MAX_CPUS=%d",
-			      scx_bpf_nr_cids(), SCX_QMAP_MAX_CPUS);
+			      nr_cids, SCX_QMAP_MAX_CPUS);
+		return -EINVAL;
+	}
+	if (nr_cpu_ids > SCX_QMAP_MAX_CPUS) {
+		scx_bpf_error("nr_cpu_ids=%u exceeds SCX_QMAP_MAX_CPUS=%d",
+			      nr_cpu_ids, SCX_QMAP_MAX_CPUS);
 		return -EINVAL;
 	}
 
@@ -1089,9 +1099,7 @@ s32 BPF_STRUCT_OPS_SLEEPABLE(qmap_init)
 	 */
 	if (cid_override_mode) {
 		scx_bpf_cid_override((const s32 *)cid_override_cpu_to_cid,
-				     cid_override_nr_cpus * sizeof(s32),
-				     (const s32 *)cid_override_shard_start,
-				     cid_override_nr_shards * sizeof(s32));
+				     nr_cpu_ids * (u32)sizeof(s32));
 	}
 
 	/*
@@ -1133,7 +1141,7 @@ s32 BPF_STRUCT_OPS_SLEEPABLE(qmap_init)
 		scx_bpf_error("failed to allocate idle cmask");
 		return -ENOMEM;
 	}
-	cmask_init(qa_idle_cids, 0, scx_bpf_nr_cids());
+	cmask_init(qa_idle_cids, 0, nr_cids);
 
 	ret = scx_bpf_create_dsq(SHARED_DSQ, -1);
 	if (ret) {
diff --git a/tools/sched_ext/scx_qmap.c b/tools/sched_ext/scx_qmap.c
index a533542e3ca52..f3218610b5e5c 100644
--- a/tools/sched_ext/scx_qmap.c
+++ b/tools/sched_ext/scx_qmap.c
@@ -155,7 +155,6 @@ int main(int argc, char **argv)
 		case 'C': {
 			u32 nr_cpus = libbpf_num_possible_cpus();
 			u32 mode, i;
-			s32 shard_sz = 4;
 
 			if (!strcmp(optarg, "shuffle"))
 				mode = 1;
@@ -168,7 +167,6 @@ int main(int argc, char **argv)
 				return 1;
 			}
 			skel->rodata->cid_override_mode = mode;
-			skel->rodata->cid_override_nr_cpus = nr_cpus;
 
 			/* shuffle: reversed cpu_to_cid, bad-dup: dup cid 0, bad-mono: identity */
 			for (i = 0; i < nr_cpus; i++) {
@@ -179,19 +177,9 @@ int main(int argc, char **argv)
 			}
 			if (mode == 2 && nr_cpus >= 2)
 				skel->bss->cid_override_cpu_to_cid[1] = 0;
+			if (mode == 3)
+				skel->bss->cid_override_cpu_to_cid[0] = (s32)nr_cpus;
 
-			/* shards of shard_sz each */
-			skel->rodata->cid_override_nr_shards = (nr_cpus + shard_sz - 1) / shard_sz;
-			for (i = 0; i < skel->rodata->cid_override_nr_shards; i++)
-				skel->bss->cid_override_shard_start[i] = i * shard_sz;
-
-			if (mode == 3 && skel->rodata->cid_override_nr_shards >= 3) {
-				/* swap [1] and [2] so shard_start is not monotonically increasing */
-				s32 tmp = skel->bss->cid_override_shard_start[1];
-				skel->bss->cid_override_shard_start[1] =
-					skel->bss->cid_override_shard_start[2];
-				skel->bss->cid_override_shard_start[2] = tmp;
-			}
 			break;
 		}
 		case 'v':
