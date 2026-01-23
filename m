Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012068.outbound.protection.outlook.com [40.107.209.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97AD721578D
	for <sched-ext@lists.linux.dev>; Fri, 23 Jan 2026 15:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769182966; cv=fail; b=tsMJ6swrICq8HgWeakQ3m0NtVkUoC0zfZPdstiDw2jQcCrOkvz8U3DkqBhACMIfpIeXwkL9QMngeHexKDwOcCBSqHGejTGHGK28iaGIksp7DPZIY7deIlPTSA8sshOyUkBsmw/YIIAFmhH+QyK2KV3TvGSZlGfVMTPV9HXFVMoI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769182966; c=relaxed/simple;
	bh=meuGQUTRZg7gGQCrMTSA8V2dS5Zj9pOUkFF0jN1FR/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=D7nPrEsnHQHwaB5oG8oN3zz4Qy0nfpVHEo34PXsEMhwNbm+fNQYATXhC4McvjDKHN3rvpKPf54Ox9Gpt0O8DUux9sSrQ75t9I1kN2QK0l2tD0LuHktiA1Z37aUxlGzm3FgT060Hw+zoU/FXWr3RKTELgGilHnGy4gAXO/nSQuhc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GnlytbPo; arc=fail smtp.client-ip=40.107.209.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GnlytbPo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OCVp968AK75nDnJDZS+DlXdhhwJkjnybaiXBxucLwcHZdl1xnVv6gpBPw8F3aSpfP8KCy/IlzZnjvxl4dgMnM9NQVszh1O1eyikKPsVr3xvKR2wG/X8rGfuUhrB41Ka0p9BYSgwAgNmIoJkcsiIV9YSvi7QwVoHV67Aj4nKCgI4mmqffD7QEKf0PiB6ELweFUGn1GmeN2tLHoWhktBX2vmfRQTho3WRVTRWThj5w1/lJ5CSpAuTtUPy5J7XFzaHxFS7LiZyChXzzS3h8hwbHPNWJmmqmp4i7oqRWoNXJYpPMWZwjo0HYt2JoZf14gxKIDJMAIVFim5nERjxutDvsrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zvzmst6jOmIFSPpCHkUM+6fAMy+x1u2JPnHD0F+Uk3E=;
 b=lDS5S2dksa4YplffGo3N87Ha9r5Fs8qkfLng30+VOASJmInqd0N8OHHsEI3ZozIKJtjXNqpC2uK3b3AU75LHw+r4d6xdVDQs7nZH9tQdlAD0Ol7UBp5azERIPJGztQYu3CN8p9bFqbP3Qu5W+Pj+D2hCkV94Nxge5C93JVKpXacVvh7O2Qhv9DazqwAYeUjFRqZZBbfw2D2cy+5wra1HcaeNzPWnnF4/LlFlE6RiLuIAGikTbnEuScj4E4Xjb+eJe1qoflg0ZV6BDy46LGORNhyRTxpduFs2P37XUI9UkrjXxCeNhXGCinJCXVprjaRCK8BHrNobWSl+lskmgwh7xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zvzmst6jOmIFSPpCHkUM+6fAMy+x1u2JPnHD0F+Uk3E=;
 b=GnlytbPodEs7HJatQSHLJJFivBqxoqYIKB+JQI5Uag4rdx8mbu7YXrYL/w1xD2j1PkaFQGwcq+QhDWfM0xvcv+fqKRvryt6puIn2k0fyUnlGgaiNYtVLkZIfiNBghFVY1yb7km+qq/VNKIXkv8+jZNlonMgZYr/+ZWvvxM1dbAsiZroQlRttC3fsbhPgvoctThvlw7CL8o1E2kPhnCUbTj8vauinjgdvGgF/qT/eGxtlbUw76xVVU9rQyy2Z7A+BY3n1heCFM7RSvS4/24CA+Ufwu52+q1PiREhPSeHWi6ycCSuSCgwRh3Y3CnPzBkHlNA8G2DMJ/PA78XkOfwGk+g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SA3PR12MB9089.namprd12.prod.outlook.com (2603:10b6:806:39f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Fri, 23 Jan
 2026 15:42:38 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9542.010; Fri, 23 Jan 2026
 15:42:31 +0000
Date: Fri, 23 Jan 2026 16:42:23 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Juri Lelli <juri.lelli@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>, Tejun Heo <tj@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	Daniel Hodges <hodgesd@meta.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/deadline: Reset dl_server execution state on stop
Message-ID: <aXOW3_2pU6SvABEI@gpd4>
References: <20260122140833.1655020-1-arighi@nvidia.com>
 <aXMfJmG499rhMjo5@jlelli-thinkpadt14gen4.remote.csb>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXMfJmG499rhMjo5@jlelli-thinkpadt14gen4.remote.csb>
X-ClientProxiedBy: ZR0P278CA0082.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:22::15) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SA3PR12MB9089:EE_
X-MS-Office365-Filtering-Correlation-Id: 0322049b-60b9-4e8c-9abb-08de5a9604fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fCmTG82rvN/OW8sBjfiA+/B7A4aLjEPQEnAlyR/6f625cr4o1Nab6XzxomoJ?=
 =?us-ascii?Q?D5sUbnobCnVg4YWJ1WoN/WpqsKk4HxfwP02WQDDBLXJeKRZO1pkTR+nkOO/m?=
 =?us-ascii?Q?eJyzD87tVRV2q9EsZSl++QHRaHNBRsKWHEn+FYn4Tpoh88xePKXCmv7xoSIo?=
 =?us-ascii?Q?akRFvzMm68NeJY5DrXUqp5VB9/WfZnHdYm7yKc4H5LeQFHScIaUmu3mDa9Kb?=
 =?us-ascii?Q?gnEqEHi5ENzAof5rdQkPjiEmK10DCX70X2te9YP7BSX7aQ1Y7iFkrWc/6jVm?=
 =?us-ascii?Q?ckhnFeQrWov2I7z/ZevFZzJU2gISJKi1oQbKbYBRq9vCzYaG4xD70POEfvZ8?=
 =?us-ascii?Q?IYYW7YhJLBu7ENsLkzSEZdlFB7cVj84mHzhWl1nzx1QmS0Cndl8pGNVoHh58?=
 =?us-ascii?Q?AXG2usgIrCtmXOAA4r/6+MOZdQai5q20UF8cMUH8scVOnu4nBIumHWHMnOrj?=
 =?us-ascii?Q?vlnf1v/+bRGde4bHEGwNENpZ1b5zkU9Vt0ax7lhpT0w1yukOZ0ZZE7t1djyL?=
 =?us-ascii?Q?tODrKSNd9W7r4bjVMwdL9gNKrm6BUdr70O9aYc3PFw4wOP69bVpIBmJApr71?=
 =?us-ascii?Q?bW+gMH11A6v2yy72g2qjpQkS7ef01el8ZJvvXxf0xKHz51Afdxu9o+8GFABd?=
 =?us-ascii?Q?Whv8tYwmRLbEsuD++R6ElSkE0HedGHYt6/W6MTfyaXZBeTjQU99TzVtlYD2G?=
 =?us-ascii?Q?VYJF+SX7Wajjjhz8V4lIs+tB+brK4wHDvFPpPdrXcaIF7ruWwZ/BXKr/Z7Vc?=
 =?us-ascii?Q?UrF6x7n2U8iwGhpn3wAsTfAjfUjkUj2L5HqHI3BDbq7i2xLR7MZ59h6b4XlR?=
 =?us-ascii?Q?GGJIAZItFl1q7vWzscHq0llFiAXXkxnYwH0ZW8wVQp01kwLUbPTROUl/6GOv?=
 =?us-ascii?Q?6CTZY2bwX5OwCEMMbZLQRkFItSCs5n5JkzeLRWbCgwQ1lb/Sv7m50Bj4q+vY?=
 =?us-ascii?Q?X6XbbFMJnHPXelEwzTNfvSKsoF+nMpdqEHWGq4SayG/+ud4tqL6PQnaIiI1B?=
 =?us-ascii?Q?6q3n20vXPSNU3wcSruzdII/gxBsE4LJveA5cHOjcBQtK4Ju2TKPm5cmg/uOQ?=
 =?us-ascii?Q?jnSlj09z/zSFyq8lzIKQc4uol2mITupN/MVR4mUgp8YpiYZNsIdL6aXxoKI8?=
 =?us-ascii?Q?O7xTC7AOB6bbudx+gL+Aeqrkj0uIHR+XyGFBQdmxMrqEpktN5ZkthDW2Nv+D?=
 =?us-ascii?Q?kLgMZLE2nC/irRzpmEQ5ENkMKXyNNHoKgLvt9Dhu7+vo4rB71mbWXa5RP8vo?=
 =?us-ascii?Q?9YWlFAd5jUFoHcrtT4qrNjKdWBkbXhWD/iQv7LSP3RhObtuYRVEeWicC9b5a?=
 =?us-ascii?Q?Zj5ZiZ2N00uJDisaAMLNHZVHx6ZxdqdfSTG9vRbD3yFZjrN1fHJdab8k9PAy?=
 =?us-ascii?Q?3mA5MFMY4Gbf9vc+5J+8BdL+786XMLiE+Zjd0jcjzQM/+r4sW6zYGuvi1dZE?=
 =?us-ascii?Q?r2QhilLQHvi+jUTEeqkAekz0tvjyUMbuoNNKuTsUzif5eme0gpjfwFZoyEOO?=
 =?us-ascii?Q?7ybOy/FmmICKCGal1yH3s2QS9foicAdoUJ09wrs2jxgWOoToC/wKQKBmNIUU?=
 =?us-ascii?Q?CCR9vG+m5yR7DuZggjs0zP1Vi73G1ekIeFIFkeym?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0Gh7OsIW6Yp4OieUWODErpD/cQp5kHWcvqtVG9JgjgnCitCY5cbVcKw5ydo+?=
 =?us-ascii?Q?aesdkm5hti+lv5ECzqyxfVzydeYc9u5oQ2UMGGnBGYVJ3ojl6rykpItWUn1v?=
 =?us-ascii?Q?5jR/AdvkSg7mqWCTqcaKsWQwdSszlZUXzM1ROvsgqr0/sxuQFs+PJYqc3xM/?=
 =?us-ascii?Q?75hygrjs0NTPjKZFcoYKliaMJ4ef0aPFhryZHq1Vh9uIsmog99TP9YjXAPuT?=
 =?us-ascii?Q?RusOFz6wg0oFI47UP4VO/gNptPrUvrWevkZ185mL/1kUy+9zUIPe3kLAJSE8?=
 =?us-ascii?Q?bDeEiBSSqOh3KSi7xxYNwq48FqJhiGVKlNnLEmHOOhMRLqBkvnrC+YwmivHN?=
 =?us-ascii?Q?9I4h+zR3OK2iVkdNDwAq93M+2PPUNMSwzbsOCl9sqk1GP4wl/NT5O0j5b3Wv?=
 =?us-ascii?Q?ZjcYSLhRNS3YIP5jnQpURZp0KPDlI+Y8srW0k6ivAoRQvpkt3Bwg7Y62PA+c?=
 =?us-ascii?Q?35IXjWSBtl8t95iCUrD/PzusyyzdCGinkTJ6UiDNU8H3iA1GgH5RcflotLmj?=
 =?us-ascii?Q?AziUZnOWgCau0tZCNwH4kmd2VntxCeKDPFtN9ABbkSyuu5n00dXPwat0c8s+?=
 =?us-ascii?Q?NhBmeyhmw9SFio8nV3vcHndfKjVeYeuH+72bpK9CDaMhME6Vcp27wn3rXkhD?=
 =?us-ascii?Q?N4ZR9tyWfpQjzpTXDxhuJmnv37LSnjNnXmFNkahV+3404vfJAtM+XecAoUOC?=
 =?us-ascii?Q?FkX9XPHLEZanIxa574R4YWSLwA4khm2MQdYbjlXFW/TKIPwSKspDB9blQUVb?=
 =?us-ascii?Q?bG027Ot2bxmzANoUeQIS9utrWzqDtXRxtQwFHTZcvz/YI4UuukKOj6Bu4cdS?=
 =?us-ascii?Q?ITVm2Pan67ZpOYKztftW6AFpsNv+jjzoGREn+XOp3fmymwprxLLoAWR2JUNq?=
 =?us-ascii?Q?unkfmDEdVm8ukthL93UZbd2uRU9fVTJReMsY5r9HWx3ozrKLH/BygKJ4Zdsr?=
 =?us-ascii?Q?yheJak9ypNIy3zq8NlfzxzZO4bLY94ZGiDIVEmmRRdTnYR1lxb8PJn2EDW+v?=
 =?us-ascii?Q?lGGS/EUrO1Z0KfLs0sdwhwO6ETXhRW+kIpBOXBPQYVofHPRrUWweiwx60RQO?=
 =?us-ascii?Q?pGmr0fm3Na7i5b9vRNtflQse2OX3mx2aNKI1KXiqu2S8raoTrr4ZXkuaULnK?=
 =?us-ascii?Q?X6jtgGlcvxtOO10HyKr7atq1yBXbX3Cn+0I/sThCg4VxYJDJuYKo7hUznHH1?=
 =?us-ascii?Q?eED4tjJPY+mBni0+3osMygpwVMW0lCI/Uk0CmLIhIrkZPepB2DDR4WuGiGKI?=
 =?us-ascii?Q?6gcKZtMzeqDkq93/bSC2QrS9AE/mojajHvwflA1is8bIUuZ88mTOcwVnaHi9?=
 =?us-ascii?Q?e+xk6EapaY1bdAzc99pMaVBACCqOuQZhZ8u173WS90L1471jK5o0Khagx5qw?=
 =?us-ascii?Q?LEn5M3k56rNWrm7ZmeHz7CiN9TslGGKxwBdmPi17Cdfo92cUMHERHCu9+dF7?=
 =?us-ascii?Q?BJpLXr0llyQtzMkuxmzOb9fabQ899uohUwbastQsCz93+OL5b0nKNKPuvPPe?=
 =?us-ascii?Q?svhNcWO2RD78OMdDW6yOrNVCDBaAayf8tsM8eEsmTTlMG1H1QcJOeIb/moeu?=
 =?us-ascii?Q?NXMWUj2g+7URsynjHcxw+ajNYH6iGZkUdLgwWHbdqkm54HiKehtLTEStBjOb?=
 =?us-ascii?Q?xE2enfX86eicwBh5NI/hRWPQS3nr9hwSxDpY7JEl2Kl4jp884683rRoskkD8?=
 =?us-ascii?Q?+uCu+mD2iygZn+S4uoolIAwl1x5pzVxYSyzYTzWp4exqKu+9beeImkd16mGS?=
 =?us-ascii?Q?904H1m3EHg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0322049b-60b9-4e8c-9abb-08de5a9604fb
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 15:42:31.0904
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x6Xv2cLg35Oi9VMMW4rhBHpzjwVpfaFJekQ+JIvAip68APiDLc+s1zbbg/v7/2vgoo37v7vsNyUEtQOs8Gq1Ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9089

Hi Juri,

On Fri, Jan 23, 2026 at 08:11:35AM +0100, Juri Lelli wrote:
> Hello,
> 
> On 22/01/26 15:08, Andrea Righi wrote:
> > dl_server_stop() can leave a deadline server in an inconsistent internal
> > state across stop/start transitions, causing it to bypass its required
> > deferral phase when restarted. This breaks the scheduler invariant that
> > a restarted server must re-establish eligibility before being allowed to
> > execute.
> > 
> > When the server is stopped (e.g., because the associated task blocks),
> > it's expected to transition back to an inactive, initial state. However,
> > dl_server_stop() does not fully reset the execution state. As a result,
> > the server can be logically inactive while still appearing as if it was
> > still running.
> > 
> > When the server is restarted via dl_server_start(), the following
> > sequence occurs:
> >   1. dl_server_start() calls enqueue_dl_entity(ENQUEUE_WAKEUP),
> >   2. enqueue_dl_entity() calls update_dl_entity(),
> >   3. update_dl_entity() checks (!dl_se->dl_defer_running) to decide
> >      whether to arm the deferral mechanism,
> >   4. because dl_defer_running is stale, the check fails,
> >   5. dl_defer_armed and dl_throttled are not set,
> >   6. enqueue_dl_entity() skips start_dl_timer(), because
> >      dl_throttled == 0,
> >   7. the server is enqueued via __enqueue_dl_entity(),
> >   8. the scheduler picks the server to run,
> >   9. update_curr_dl_se() detects that the server has exhausted its
> >      runtime (or has negative runtime), as it wasn't properly
> >      replenished/deferred,
> >  10. the server is throttled (dl_throttled set to 1) and dequeued,
> >  11. the server repeatedly cycles through wakeup and throttling,
> >      effectively receiving no usable CPU bandwidth.
> > 
> > This results in starvation of the tasks serviced by the deadline server
> > in the presence of competing RT workloads.
> > 
> > This issue can be confirmed adding debugging traces, which show that the
> > server skips the deferral timer and is immediately throttled upon
> > execution with negative runtime:
> > 
> >  DEBUG: dl_server_start: dl_defer_running=1 active=0
> >  DEBUG: enqueue_dl_entity: flags=1 dl_throttled=0 dl_defer=1
> >  DEBUG: update_dl_entity: dl_defer_running=1
> >  DEBUG: enqueue_dl_entity: SKIPPING start_dl_timer! dl_throttled=0
> >  ...
> >  DEBUG: update_curr_dl_se: THROTTLED runtime=-954758
> > 
> > Fix this by properly resetting dl_defer_running in dl_server_stop(),
> > ensuring the server correctly enters the defer phase upon restart.
> > 
> > This issue is quite difficult to observe when only the fair server
> > is present, as the required stop/start patterns are relatively rare.
> > However, it becomes easier to trigger with an additional deadline server
> > with more frequent server lifecycle transitions (such as a sched_ext
> > deadline server).
> > 
> > This change is a prerequisite for introducing a sched_ext deadline
> > server, as it ensures correct and predictable behavior across server
> > stop/start cycles.
> > 
> > Link: https://lore.kernel.org/all/aXEMat4IoNnGYgxw@gpd4/
> > Signed-off-by: Andrea Righi <arighi@nvidia.com>
> > ---
> >  kernel/sched/deadline.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> > index c509f2e7d69de..214fe62a59723 100644
> > --- a/kernel/sched/deadline.c
> > +++ b/kernel/sched/deadline.c
> > @@ -1813,6 +1813,7 @@ void dl_server_stop(struct sched_dl_entity *dl_se)
> >  	hrtimer_try_to_cancel(&dl_se->dl_timer);
> >  	dl_se->dl_defer_armed = 0;
> >  	dl_se->dl_throttled = 0;
> > +	dl_se->dl_defer_running = 0;
> >  	dl_se->dl_defer_idle = 0;
> >  	dl_se->dl_server_active = 0;
> >  }
> 
> The fix looks good to me, thanks!
> 
> State machine above dl_server_start() might need updating, though. Don't
> we want to add dl_defer_running = 0 under dl_server_stop() for case [4]
> D->A? Also for '[A] - init', dl_defer_running = 0 (remove /1)?

Definitely! I'll send a v2 with the updated state machine documentation.

Thanks,
-Andrea
