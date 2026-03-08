Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011002.outbound.protection.outlook.com [52.101.52.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8E11E505
	for <sched-ext@lists.linux.dev>; Sun,  8 Mar 2026 14:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772978535; cv=fail; b=RXEqeGYp3s47VIh+45p7IEeXxaDAhFCqAfYtrqKTHudenBWv4MFHe1slWVizgT04zAc0k36uSW2DlEYTBExQdb5CtagmVm8CVXuQSG2lprIFKlgPOkpNZLm+KGZ1V7WCxZ5fJNP5bc8VzBml4363WdLsgQgKrZowuGPysTXwv0o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772978535; c=relaxed/simple;
	bh=iY/BvNf7rxk5rsoZ0CjW7piV5cgqeYoKCTXA8Q7y1CM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IMgU6GWmy340KuTlCnjBSUI6rdCaHiiI/iAoenKQsTRFhj3tkS60Ic1j+eHDfaevwevQjVLavE6KxiRSp4fjD+PL2wyWmwcZ7C+iHOG2HgCuPrNropc+4mFMSc1zt5ULKcGJ8PBxtQaDmVOkpLmX1wcf2urFEZLJtNBaabXUqz4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=l7mFrQ1A; arc=fail smtp.client-ip=52.101.52.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="l7mFrQ1A"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kAPpjMe7ObkTSP3GjoD1LN+yh72iPixwZACPh/EqatiAJSLBj46vEZBGQgDGR2kUlNaZ0jv5jD56ITZj9UI6Gpi96UeJW8laf0K8j4LtHUWJprcgBqD9EufKaZUa5cczZLddSA/O/ON/RABgk9EIFyqbuJsGxkEAua0vcB9kmgbiD64gpevRVopAWGFd/9EqjtQOcq19r0hdupQok9uqeOXlX45shv5dHTFa0E/ANT7X8XsptQJJXxJXifXPzXQgWIhMeCU6Kmxon6IQdvTl9LPsAD+Bw/BosJWDzXiDkUyMUZrGjC3WOc+vQ0HTMuwamGNzsYRdvnZx068fTIHwHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I57JcA4gDK8sijpZhYrvynQpLUk5jJjkazCdEVGrTSQ=;
 b=LlvppQqgg0Uf0JMDJt+q0CjtJCr9rK24GpJSka18+5/VZK9Qqky7o0Vyom7AdY/a5rGgS5UV7lG5Gptt0N8CsO7whMZxL1bVMhSBh67rSYFX9d/SiS8Fe0HTf3jgJ1ekD93eiz1Zysjm7NHcevqZeliRbmnPNZbWA85eRXA3520qWLOMWoiz2MFHCaCyqiHrQjMMoCHzhbh3n1GrNHKAzUXeAVPRiF5Z0gaJfaKU1123DZ1+xmW1zn62Vjk0375bBbDNWUOn9g+2sOFQ3+secNmvq3swGb3oAf4RPuYIiXdnBptZrwSaNW4/EN1aVAPjq/qCYQODIaYQSj8H9oloPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I57JcA4gDK8sijpZhYrvynQpLUk5jJjkazCdEVGrTSQ=;
 b=l7mFrQ1AUHeSuk6fknWPdMAeEtPMPOhWq7xW6HB2/gLB3u/1pB6nbDyxFF8uzCJFwc42/uNruxIYkwzzUw0Yt409aI8SL6k7CSiUMhTe5UOWiHoa6Knq1SvWhDBJc7Jbt/DFtISN3kxmG1ktbQhABR/jfkwsZ7GYVvOI2eG9mpXt1gS2wlczn/GKAYtheokqVo+U33xHL4N1LvQacqVsQqNzBA5baV8GCtbesaSgXei0ayh/8ooKaxyYHOb01BBump6Mrls8EtWDkCwNMSVExSXkdpgsYXTQhAnAzQkL0YgIkPHXFmoghIYDKxDBluMiVe2tWdxs8JjI+PDmDKBiSQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by PH7PR12MB7380.namprd12.prod.outlook.com (2603:10b6:510:20f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.17; Sun, 8 Mar
 2026 14:02:09 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9654.022; Sun, 8 Mar 2026
 14:02:08 +0000
Date: Sun, 8 Mar 2026 15:01:59 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Cheng-Yang Chou <yphbchou0911@gmail.com>
Cc: sched-ext@lists.linux.dev, tj@kernel.org, void@manifault.com,
	changwoo@igalia.com, jserv@ccns.ncku.edu.tw
Subject: Re: [PATCH] tools/sched_ext: Fix get_prandom_u64() prototype
Message-ID: <aa2BV-YMfe_NHFwV@gpd4>
References: <20260308130638.719915-1-yphbchou0911@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260308130638.719915-1-yphbchou0911@gmail.com>
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
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|PH7PR12MB7380:EE_
X-MS-Office365-Filtering-Correlation-Id: 12672d77-bc73-4f8f-8490-08de7d1b4973
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	TC66BveIjr9dR+fWIH69ZQ4J44Bqwh0pFKvLageD0jei7wBY3yk9q8etKC89WLyqPA84WjyyP3F3oPk39Km0vHFroaky9ElLmRrMFXdQtNoNloualTbX7VAiGWTQ3w7/un4un3XWpIX5xHZ1Aetw1uSf+Urd1TZ8bSWz+obbXfmxuG93HHwNkCqoE2KW5NhBkxqKCbvaX8CCLD1lZemmmDnRa1qgXPtk8LTaUE4ws7pbkz9vZMTIuJpEDonwZDVT5AaClh44Mx+6xpyrwGb+iFTdt2raywZSZIONBRQp6txOY/FcVyabnxWGv/SL+AdBOxit/rovowgZadQVmik19J+QHlolJlCfVW8IjC6hhcaKHTYL5F98Xw4+xLaEcZVlqcFYyjdavPp0O4OL+ociPSYEvTQAwfpZEI7XkUqXWfZ56Gr2fHBfLQMwLN5CL2Cl/NJ0O+gKapy/b/juQiByvyLG2qMENYepEO6DZwOZDxnYRiJe2+0eWQmoOyF7FlsUvVU1yy9b9mxKBNNqpssAHkWpkSD0TKaK6kRryV41f/aD2oFXAg+0FLkM8t+JzZAPonAtBGoUzQSfgFbmhPCKymBcaiab0LN0QGm6iR14BO9EAL6NAnJVBeD81sMAJFQ+AiL/Eo29q0eGgoW3wStxNtdnt6VdaRsJDur0tT0dR73YmsroVALWu4RUjt14DFnIlfV1QKM0BGlBLJ94ZbVCZjt+GVPa/JfHHeskJiN/bNg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NajMZ/qHMM6JeVDm1Bsc21jC1PakLnCF+3iHb+5bdA0pPzOzUUrMjYUc1icU?=
 =?us-ascii?Q?XzbifkuOROdk5ct/gp9lcCWfyK1csuG4Iar80Xu+3vM47Hpe5gge6mKZtKhX?=
 =?us-ascii?Q?Qd3dZyJZ+8ySDQNLY3ta5oIHI2Nko+8VuRVl2jM58KN6mZTbyp39FCoXW2DQ?=
 =?us-ascii?Q?RHCBPs8v3qTtrMYfgYq9B3lfCmIiVTRHjq00WKnGTES3FSy88diseJGxKBBI?=
 =?us-ascii?Q?KLAuURW8iy0AwVSQeEvmdFPZnwBtkG27M3LfKWRJrHF1iU+dGgX+YxyAq/Xh?=
 =?us-ascii?Q?iMNkiHsEsVLWChb4msPDO9f42jW6ylp65urhVj0YgbAxdpjx4S3LSIySgSSH?=
 =?us-ascii?Q?56VssHqgQgdIHAh0n93isDQ0OZvfBKOte+n/HCIfrLU8nfbF8vbLYSm+xwBN?=
 =?us-ascii?Q?jL1lrq105Qkk0lQt5KMTZVJbarYL+mBcQgjRWgkF+jH4k9xMHA4LrHA3olOd?=
 =?us-ascii?Q?G3M3B7SemMiQHsGx0cafMMy1puFBxGRHMZ7s/mT92C9s0Ub1+Ut09kAXP8En?=
 =?us-ascii?Q?BP/z/eoAKZNZ1i05UaUc14ktzAyx6TCahbDmAl5oQTxaBdUVtVzpbeACuTeQ?=
 =?us-ascii?Q?uZocYuQ6t5Tib42ggY2A7DZMzK5E6nlLTlvdvwYYB6H0J9700Hs7Pn4Dsovr?=
 =?us-ascii?Q?AEm5dr7TA9r4PmN0wjB275QtotT82kPIFHNfl5eIZoDE2QF/SAkh39budt4l?=
 =?us-ascii?Q?wEiC0Ksf5w54qFjJMHgh5ipINLiIDT81Frl2veluVIfub8vefw2nnC8xHkKg?=
 =?us-ascii?Q?Z8AYSPHbwmnN3ghMaC9uxDeUuu9HuIUNon6fLQ+HPzUC1k8fmFhCiEdYiMFN?=
 =?us-ascii?Q?H2qc2RInRTWMLHr4VgF6AiA6/54foGOH9n6/amdVMp1ybyCEZrnDCWxHCLdr?=
 =?us-ascii?Q?l+vJtCGhacifGYu0HMGivj+q3TePAE6iB/jjbzhL6buNehgovGojzHtUaV1+?=
 =?us-ascii?Q?3B0iEWcdosW9XixWwhOUlULDtcHn+wpuG7iH6VdocJ1ZqPB05gwIjZbT7HOR?=
 =?us-ascii?Q?cOfZ9CRpUZhuXgx6IMLh+11fse09sMTbZR1QgfRzMHuwiR2vYEupYNV67xrD?=
 =?us-ascii?Q?/NuTn/wvp+jfjAB9sKXPiDlWQ1VsYiqFhY780StPL0Q/aS82csvGn+PgAH7+?=
 =?us-ascii?Q?g18RBE5E9t3f/UVJEl6dmI7wx6LbXngY+g3p7jrYSCQeBPFpkN0KfmqfHIn6?=
 =?us-ascii?Q?VP3Gjm2/EYEg0rPDxKP00oxyv1W3sji/QFvzY+z1YTx0L1fie6XJHP2r9KbT?=
 =?us-ascii?Q?9thGO3qat9aDlnvCHkdBF9ww1q9h/74nquZf2uYo1+MBPem9B7NY3D6McvHC?=
 =?us-ascii?Q?FG1Vy9jCEP3OhtPg3OK12d6LqeFKwP6ZaaZqrQRo76GMSsro7Z+YXs/iPy0F?=
 =?us-ascii?Q?+kBcPMyERToWtUfXj+Yfujk9hrfEChgLBXgPQDLrlMuiuzCMb6MvDLcQr6EL?=
 =?us-ascii?Q?2aI+MhS0GjwPyo2FGC+3lmv3706U0imaS0bWCVcZAokn6P6elIChNe8z+dtr?=
 =?us-ascii?Q?CVyJJvKjtGfFLTeu3BPzHsD6HgD04S8g4pJHtSJvk4/HmO/igOj6mk83pcvF?=
 =?us-ascii?Q?A8Qqi71rTLTGxCgGNCi7tZxVBg45OhgFrXfc1QZ85/xfyfUOs3XqctjnujSM?=
 =?us-ascii?Q?0SbpK7OPgQkDT3VTpjdHVA77Bd2u66S1pI2pQeleU4UiL3wWjCpBkjz6ehRm?=
 =?us-ascii?Q?F1NKPRziie9TJcQ0+1gbCnYjr/BhJboY8h0jPXp4QdBbzaNPtsG1o4hRqq2k?=
 =?us-ascii?Q?noq5WdVnUQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12672d77-bc73-4f8f-8490-08de7d1b4973
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2026 14:02:08.5089
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5j32CRxsb3vqZcCj1TOAOfvUEfnF5uJgjcxdIRqBnN0fbQg5vHpHi9t/5GFJByMEpk0SUFDGgkk5M8Z/EjlWCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7380

Hi,

On Sun, Mar 08, 2026 at 09:06:38PM +0800, Cheng-Yang Chou wrote:
> In C99 (Sec 6.7.5.3), an empty parameter list in a declaration leaves
> the parameter types unspecified (K&R style), not explicitly zero.
> Consequently, the compiler would silently accept arbitrary arguments
> passed to the function.
> 
> Declare the function with (void) to form a proper prototype asserting
> it takes no arguments.
> 
> Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>

I understand the motivation, but changes like this don't fix real issues or
provide any measurable benefit. Patches consume maintainer and reviewer
bandwidth, so it's usually best to focus on changes that fix real bugs or
provide clear improvements.

If you encounter a real issue or can show a measurable improvement (with
traces or numbers), patches addressing that would be much more useful.

Thanks,
-Andrea

> ---
>  tools/sched_ext/include/scx/common.bpf.h | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/tools/sched_ext/include/scx/common.bpf.h b/tools/sched_ext/include/scx/common.bpf.h
> index a63a98a96b86..99b1a94097e7 100644
> --- a/tools/sched_ext/include/scx/common.bpf.h
> +++ b/tools/sched_ext/include/scx/common.bpf.h
> @@ -621,7 +621,6 @@ static inline bool time_in_range_open(u64 a, u64 b, u64 c)
>  	return time_after_eq(a, b) && time_before(a, c);
>  }
>  
> -
>  /*
>   * Other helpers
>   */
> @@ -870,11 +869,10 @@ static inline u64 scale_by_task_weight_inverse(const struct task_struct *p, u64
>  	return value * 100 / p->scx.weight;
>  }
>  
> -
>  /*
>   * Get a random u64 from the kernel's pseudo-random generator.
>   */
> -static inline u64 get_prandom_u64()
> +static inline u64 get_prandom_u64(void)
>  {
>  	return ((u64)bpf_get_prandom_u32() << 32) | bpf_get_prandom_u32();
>  }
> -- 
> 2.48.1
> 
