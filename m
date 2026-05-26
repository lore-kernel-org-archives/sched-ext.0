Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011061.outbound.protection.outlook.com [52.101.52.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B9C41C2FF
	for <sched-ext@lists.linux.dev>; Tue, 26 May 2026 17:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779817492; cv=fail; b=IlW3I8T5ZozctdFfya8gLn2VoOtxq8wWx5mjJ3zqKXOvFNLUrIj11JVf6jNE3cIiY71Xo6kk9UwhzxLsxEswzaqSYBcIuAxq9BdHVWRjLtJvLghfr2Da14F1RpYIiCmWgWnSqHQ+hoCvZX1Dw+Wo5LAAslzkeCb3j28xFDrDKeg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779817492; c=relaxed/simple;
	bh=3sVCR2ee6X8nF1DLp2XOv+iH7UqKrRZEAxL94YxyeVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PNnTST/8trWoP/Ox0lxbOI+YFfFg4+xcoQN6xMGMw9q+g8naZRGncoi3C8J3+GWfhxWnhiuwg94v4rAn35QOCp/+TLpIIG4ee4b53rjWNR6FvTzLlkmWdiyvOIKXSLJymV05OnUA1VDzqFw4nT+mdp+fw2wDhzvi6iNEZPGNCvE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=B5papTs1; arc=fail smtp.client-ip=52.101.52.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="B5papTs1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hse7pH1WYK7GJEcJ2Z+QPjPtTVxWYI86K1G9lU9wj/fmzeDDToJKnmQuFXDsZ1lar3CNtxtbIStGYsjUNxnzku/feC8IwrnCP0tvp5fA7QQOzhT/beFAQG48xKp5klcJd/rgx8StuL+mVRuBa/gvd/RPaHUaL3rd0hKwf0xVCrPMEuDsLZAu4bOkJDjEh59Vsh5QldQMsY+P8BGqiB5TmOgMmIwEjA5kYIb7wgtOKe9p6WyBYnchdsDj6ak8ER/nt2+hmvKa/FjwGtlHFWakAlzkhgTNv1AZ2S7UXwCPYbm046ORv8kt9h+hYPinEfHhYsB4prtowzmatQ2rPGMkLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vI0C6ock4BZqr4SrMIdT/Qa2lTyyaNXl1wBK/4Q7cqU=;
 b=ApklCGWIWGahqVvJvLfcf4zEVAdVzrOfXrzrv8ww4K4LpkWz1mWE7Tle83hwe/gryI8dEXWRJNgqNSHA8bqwJdJSxzU0gN0eV9lXkZgtM+Vzk4i1R61kTtTeHKw7Td+5er5Dx+QNT29iw/55nxVxsQrQzVNN6IXssTFAmmvOvxcpGy48lGKNq2Rx0EfG3lLI1UmkY9SYYCudh1HiLvj9FU5W9uOZ//tkLw6dliayocFsN63W8s/s0SNJUCnj4elpHbcvE8hnk610ncoT2R1bRwKk+PIRi9/nyjvI40f4MxnP0KCykzRxaUDBFHqxTG4HAhWzCA7IgZ0TaXEr1zro/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vI0C6ock4BZqr4SrMIdT/Qa2lTyyaNXl1wBK/4Q7cqU=;
 b=B5papTs1M+Jzoa91xWfqU1Xg1xrfA3io0YDW202iWDT+IA9vyj41RRakB8d4gsb4rLjRF1MxY5uAcD25WYSZat8/VPdc1BOPjJ8EML66JXDmEkq7suhOEodXQ959IgnO6FEKBVGtDGiuQeh7bF8gotuSvMq9N1Q1Nen8KXtM3xKgks7f0vrSuKCKbjZslyZZ/VqqH1Ixj8PN8pty/xXOtdSNfe7JUEMNAgTDNZIU1MqLxsYK7HHtR0yU84AKYe8Tri9KHgVDFWCj2OGxB4I8tY70oH8FubNHAj/9xogv6HXz08qY8mKdd3+PHSsL0rkRKGJk7jTOktFsIRXmyoofCw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by DM6PR12MB4107.namprd12.prod.outlook.com (2603:10b6:5:218::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Tue, 26 May
 2026 17:44:41 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%4]) with mapi id 15.21.0071.010; Tue, 26 May 2026
 17:44:41 +0000
Date: Tue, 26 May 2026 19:44:35 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Zicheng Qu <quzicheng315@gmail.com>
Cc: tj@kernel.org, void@manifault.com, changwoo@igalia.com,
	enjuk@amazon.com, emil@etsalapatis.com, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org, tanghui20@huawei.com,
	zhangqiao22@huawei.com, quzicheng@huawei.com
Subject: Re: [PATCH] tools/sched_ext: Fix scx_show_state per-scheduler state
 reads
Message-ID: <ahXcAzxZbw6g_dLO@gpd4>
References: <20260526135123.1892092-1-quzicheng315@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260526135123.1892092-1-quzicheng315@gmail.com>
X-ClientProxiedBy: MI3PEPF0000753B.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::4cd) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|DM6PR12MB4107:EE_
X-MS-Office365-Filtering-Correlation-Id: aa13e45c-d66b-4db5-3d43-08debb4e7735
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|18002099003|22082099003|56012099006|6133799003|11063799006;
X-Microsoft-Antispam-Message-Info:
	ezNLxmFAG8/Ebc0uo1ErVBB7DgwDnFKAYjzR2QcvbjG2mKv+f7FoXv/g2XiTETe70QYhuTadTVEbHkIxfdELxYB3c0BI2yPMSHYj/+O9pQXY0F2vsTM88/0Nv4sDHStGPyDoAaQZhqS1HOG1LLTyMmgYPmH5hIQfA9jjdBG1YNaGDvax4NAdIDo3hzHwa2TGnvhxpxRcHzqiSW5wa7W6rc/Y2P0qnYI/0/rhLO6mv8yqVJA0TNJhgq0ee3R06dylbkrHCgDdQ2SdRpv1lSVJt8LXrWqj9/SE/BOs7q6qyLQ/T6xngaOJmYTWTyhCMh6X26Vmqzi36nyyJGGo69mSFaiaHUWe1O+YLBt0xMCPrHk9hc9RufJGAsgvtB/lh9rieZfozn9hEUmkWGFLao1s9eswC5+O5HBfCBWJL3+eT22FrrG/QAFE4VWwbXovn9saa2PpsmpdUQIl26qFD45qNqQwhTnNR58hXZONoTDTWWrhIIPbMQCZOnxaYCsr7a/0tAjncMskBRBKrWf1oo4753144s8ydtCj6LlkJ+BLAmZFIyZ56nuNs4+XPHyFumlK1hY9Cd+dgT3iXuupV5ihB/1XtplxN9vVtBqS8VZinj24eKOieOcW/xD4keG7slGtaFnIIrr097WtFxiKsf37mcrywQOU2WE5b7Afsr9Xct4uYmnNSGMvJ9jVNrp5LNOj
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(18002099003)(22082099003)(56012099006)(6133799003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ocrbTZns1hQY5GZkxHxtim7yDs05wuASiMEXgFs0unvcnq27SA17/btQnn5B?=
 =?us-ascii?Q?L8t4yxA97BKxLme/cRP8u3Zh9Ins88cNyrxjcx6/WuvpMNMjR3lKmb2eW4ki?=
 =?us-ascii?Q?OtyCF6EMZK3guNGzsQZmOgtvTxJYJx42seQvK6EXTLGZDl5AOhFJfY5z4Qwf?=
 =?us-ascii?Q?5g4g8NIm372Fu7pjS6RUMxCHbDZd3AlYzX6l5ewd0LE/FIvPlNHb426tObxH?=
 =?us-ascii?Q?CXOy/f4fVRLPGK9i8C1yPOnf/wVoSMkV+eD0k15YOu+zDzT1g33StJvgXM2t?=
 =?us-ascii?Q?oB0FlAXScwY7IwhauoPcDqk8bWCtC7ERobc38UFu1F1+1B/wSXXNSVnbiLsw?=
 =?us-ascii?Q?QDXqQKrELJFgBP1Uu6Xp6Qmjte05+96IJvGLpboY52bj+oNWiVGoSlS8Yzap?=
 =?us-ascii?Q?HLOlONkw0qvQPOdraCSLbl0Bc/jowt17fhSJzWcf91vNwXehDV3T2CP/wSeB?=
 =?us-ascii?Q?U3B+ibhjVO0elGmtic8eqvDAZKRKgf37taw1XvM4f4456Z78ZBtKOmg0K7KN?=
 =?us-ascii?Q?2631YDH1/8Reo3OI1a5iZ44DKWFXloNUwk4lcPVQcUrRvLlKOR8nVd5A1Mcr?=
 =?us-ascii?Q?lzX0dK724jTADwl+D8EKnk6BvNnZeRIShC5fHjgCKN7btYf/La9/Yq4FqWC0?=
 =?us-ascii?Q?iye1/BKwMrOZGpL+m90aS/Btgvj1KYKDayaRthu5/4Xm+qG84ItHd1BdBK6r?=
 =?us-ascii?Q?Pge+71U0GKuAatKiXjz5bcjdQyoin0zvTh4EpWz2z/oDyFCyQKi/2aay4epi?=
 =?us-ascii?Q?v5riWDNueW87WYaTjYCJNzxHCIUF4KoCruQ3igTDGsM+48U40yB+l8n1oTnA?=
 =?us-ascii?Q?1EXu7i6a6d5oQj4uJRhR5W7q/CZEuLmVbktLJ0CL4MfjnheegiS66I+4kNlX?=
 =?us-ascii?Q?5ov8txn3NECKsZhQ4214uLNcm9m7htNl/BlZh3ZL9qW1bLTDGcywL4hG7sTp?=
 =?us-ascii?Q?x2WAs7PCLrbdgyJTNXTphyxAbcaRUinLzWSVufXOlynnnB6jc0+8QNs6tp2Y?=
 =?us-ascii?Q?2Owi7ENCAdPyYziYos5mUeQCcEW36ireP4JQwrgz/btnTouPJKRth2n/A9RA?=
 =?us-ascii?Q?wdlnnh65wi4HCC1cUsFW80d4T2qEqO44QK4RVZkif/rdFkW+YU9IKLai7GLk?=
 =?us-ascii?Q?x+I603BXXLfJsXyhKaJ9z6qdw8SBVAPBxTOWSNfRCNDn4M/GdWmy3QIf23v3?=
 =?us-ascii?Q?4Vp3Muw7VTeLZ03DsPw1gfqB7ieJYxIuZFciR2BERzGSU7N85gJTxvl6C4p0?=
 =?us-ascii?Q?PZZ5JkRfm3c2vlF55Xf1lZZOTRihb2qVBBRuJqIJW2siz1/A7x1bBeTVOwyh?=
 =?us-ascii?Q?pAG278MkrH7oaTHyqDL/hm+9LmvwNvY0KTrecdC7IqE33NyW1u2z+iQMKk7c?=
 =?us-ascii?Q?220dX4+Vaq7L3TeZf15itn57QTlCqrfv3g2NHwuyrKlSGAVOYaB9bwScAsas?=
 =?us-ascii?Q?K7eX5Tz6CQEvRlaHC9XKJ7ezJqO11ByzpPZX0BA68Z/kTzK1cqF6rdB8CSj/?=
 =?us-ascii?Q?ezJOLhQhtQYzbCOn3j6Wehnz+WpwotGF2FevQSrgWJMKGJDazo/SZ/fDRZFS?=
 =?us-ascii?Q?VF03CxuKZ4VPg1cbThyVcgqpbq4voZhU+ifGqGxSM4tZu/RjJt4zi8TJF463?=
 =?us-ascii?Q?/028fhZF4w9/DSrwisxzsHiwoAfH5KC9t3RxY7bGCOdFkF0oDVhQFuBwrZY4?=
 =?us-ascii?Q?UmjlfcHCuWgHu6dD2UouahgEMc2rCjnij33gdI0eTY2PIUh+SUym0UMh7OMY?=
 =?us-ascii?Q?RhxoiwAx/Q=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa13e45c-d66b-4db5-3d43-08debb4e7735
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 17:44:41.7337
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kSuaxmvMQZ/dlgseAPdgncBmSa3PpHEmLBxDgEPkDHFcekj7SjtTR1T8eq45im/89H7IZGwPuxAO7zxhYzP7hA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4107

Hi Zicheng,

On Tue, May 26, 2026 at 09:51:23PM +0800, Zicheng Qu wrote:
> From: Zicheng Qu <quzicheng@huawei.com>
> 
> scx_show_state.py still reads scx_aborting and scx_bypass_depth as
> global symbols. Those symbols no longer exist after the state was moved
> into struct scx_sched, so the drgn script fails when it reaches either
> field.
> 
> Fixes: 5c8d98a1b4de ("sched_ext: Move bypass state into scx_sched")
> Fixes: c1743da43cf5 ("sched_ext: Move aborting flag to per-scheduler field")
> Signed-off-by: Zicheng Qu <quzicheng@huawei.com>

Makes sense to me.

Let's keep in mind that with the sub-scheduler support the script will only
report aborting and bypass_depth only from scx_root (not the sub-scheds). Maybe
we should mention this in the patch description, but the patch looks good.

Reviewed-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea

> ---
>  tools/sched_ext/scx_show_state.py | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/sched_ext/scx_show_state.py b/tools/sched_ext/scx_show_state.py
> index 02e43c184d43..446d82807f90 100644
> --- a/tools/sched_ext/scx_show_state.py
> +++ b/tools/sched_ext/scx_show_state.py
> @@ -27,18 +27,25 @@ def read_static_key(name):
>  def state_str(state):
>      return prog['scx_enable_state_str'][state].string_().decode()
>  
> +def read_root_ops_name():
> +    if root:
> +        return root.ops.name.string_().decode()
> +    return ''
> +
> +def read_root_field(name, default):
> +    if root:
> +        return getattr(root, name).value_()
> +    return default
> +
>  root = prog['scx_root']
>  enable_state = read_atomic("scx_enable_state_var")
>  
> -if root:
> -    print(f'ops           : {root.ops.name.string_().decode()}')
> -else:
> -    print('ops           : ')
> +print(f'ops           : {read_root_ops_name()}')
>  print(f'enabled       : {read_static_key("__scx_enabled")}')
>  print(f'switching_all : {read_int("scx_switching_all")}')
>  print(f'switched_all  : {read_static_key("__scx_switched_all")}')
>  print(f'enable_state  : {state_str(enable_state)} ({enable_state})')
> -print(f'aborting      : {prog["scx_aborting"].value_()}')
> -print(f'bypass_depth  : {prog["scx_bypass_depth"].value_()}')
> +print(f'aborting      : {read_root_field("aborting", False)}')
> +print(f'bypass_depth  : {read_root_field("bypass_depth", 0)}')
>  print(f'nr_rejected   : {read_atomic("scx_nr_rejected")}')
>  print(f'enable_seq    : {read_atomic("scx_enable_seq")}')
> -- 
> 2.43.0
> 
