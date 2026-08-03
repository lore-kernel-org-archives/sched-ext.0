Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011069.outbound.protection.outlook.com [40.107.208.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF481F2380
	for <sched-ext@lists.linux.dev>; Mon,  3 Aug 2026 05:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785736037; cv=fail; b=KjTUL7tUpSTVJnatXVMcaWI+7iV+m09Uikoeb3TcnIglh0E0WiA8zZQX7m9sm4OdfPEBW8IaChZr1Z+TJNCij3mtZ1tumbi2UBP0aree6awsPrSQtnip6yppenMazaPBP1giNso4owvTV9W5fjKLCr5W+zCo6trJFZq5u1lbgAQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785736037; c=relaxed/simple;
	bh=PCvLiHL8etPxi8QR+W0NZ6ltnF2A4SBTyp7WgCsg80M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eXVk9rSETts/XYidejVo1DMUVBHtHuSdEnpAt9frP47bBsQgdqD0UwJwgPrrgrnZNLweUhV7/266R6XAuZEVNFU5RFBOVuf1M9Z25iVBsxjFiSh7T5PjHGEZwZpGVP4sajlRWZNGzBEjxsCyE0zE2LRV6hGVjE43sF2au3k6YKU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DvB7DLda; arc=fail smtp.client-ip=40.107.208.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DvB7DLda"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YWJGUnSkZWrfqAo1uHi29W82l3/ItcK8qZ9R90zEz6dO8+O2EQPzAkwHtHBgA8IebL2tQ1sA21ge3lXeKD/TRhjt0w0URWtp343dJv6fviCwQa7SkAPaBO6d8nVQ04OLW/TljTkQtQb0aDLR2+1e3fmKBhjz5B8iiv5SVaf1WB+9KtnJ5gBYw/DESe7m8EuhGR3rA/czOO3JdiQK7E3Uso/ZfN7nBPyzD7VhfQcuoYlokjjJ55TeGSZO35f6SMfiDodpnxnOsas1epq/gofDYcLEB0E5dxgN9VWdKiW43+9z0nRI7BlUGvG20dmxjmjmgnUGkFu7oQeWd9bvIwFnmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+axCPuaVmV3H1zmoFhRxPMBxpKFVUFsx1lkze7DZcvQ=;
 b=jj1Eu76IKQpsONDFOCgFGJMHxSVk74G3eecuiBgrCR/dIdn3fnlTMIF2fxfzX+YuESxktj76X5sjZVD6GJlEZODvLD4L914lelUEJnFw0bpGmoNkbhOFsPKH82TsC9x4xAFCmDefmZ5qZC3JlnZxDqD70EM874b13Fd2MnNHdccP3hrxLLMYBSbQW9J9PrpsPy5yezA6HdcUmjQpliIF1xToOJYwlRsDIiUKyezVZ7yVQGZCxtD0J9XwGTqzAIqgjTe1doRIuUIw02tGEb7lTA82omo0AGYdizi61JGs+Bt1/8P2oiG/MALifMm1Da8JwNx8R6tyj1EoVCdkZYJdSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+axCPuaVmV3H1zmoFhRxPMBxpKFVUFsx1lkze7DZcvQ=;
 b=DvB7DLdaD1xash6pyzP6+qp4gvu75fS1PujkAczTgtBviI3TvC9zZJ0rkU74TUSruBHbIGNqvlot15Dyuwbms+IHCypG4S72gRDAx/A5lJsXq1dv4f5GDYyFIr1ssO9ey+lrNhrfe975PCLySoMCp8AJTMtLUz3djnxG9STGQnPOq2+78riV5io9CoNNHBVDZvX1gOLYuFuwX7Ex8pYB4VvDkgMg81A46R4vZq1yEHtuSumRLL82AXc6peyG5WBzpxpZYJnUmbAxs6pMOF9bYgxA/rUieu+1ffO1luaNVgn+5MoE6TC+1od/eMF62H8ovfTEk/jd9xXztRQXOXgmoA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB4827.namprd12.prod.outlook.com (2603:10b6:5:1d6::14)
 by SJ0PR12MB6853.namprd12.prod.outlook.com (2603:10b6:a03:47b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Mon, 3 Aug
 2026 05:47:12 +0000
Received: from DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c]) by DM6PR12MB4827.namprd12.prod.outlook.com
 ([fe80::6261:3040:864b:159c%5]) with mapi id 15.21.0270.016; Mon, 3 Aug 2026
 05:47:11 +0000
Date: Mon, 3 Aug 2026 07:46:57 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	Kuba Piecuch <jpiecuch@google.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] sched_ext: Initialize idle masks before ops.init()
Message-ID: <anArUap-URclDfww@gpd4>
References: <20260731182406.3166853-1-arighi@nvidia.com>
 <20260731182406.3166853-2-arighi@nvidia.com>
 <am-YVNN5Ga12zHpM@slm.duckdns.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <am-YVNN5Ga12zHpM@slm.duckdns.org>
X-ClientProxiedBy: MI3PEPF00007534.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:298:1::4c6) To DM6PR12MB4827.namprd12.prod.outlook.com
 (2603:10b6:5:1d6::14)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4827:EE_|SJ0PR12MB6853:EE_
X-MS-Office365-Filtering-Correlation-Id: c0706bc9-1c90-4989-bbf7-08def122a9d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|22082099003|18002099003|4143699003|11063799006|6133799003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	rpdN5RD/Hv0eVMxhmjjuFxl79bh6Av699nWevRsl02Z6wn3Xr1+kQfCg32NX0n/NB+TIqhleflRc2xXuCsxi7WKJfpi6S3EHnvHtoFSZ6EH7VhoH4q5ClWnoLwq+szNusoK21hX7xX3l+sDCINWg5bL6gvf85vadX42pMlXWf5bqybNp7jK2OY69+u8KcXfgGB8QFq/cSaKjXXqOD81OFzzNr6CflzEQhcYkBeYqe3qTKwMNpumAHyYSMnYQhuxpqiN9vDSTqc4H78ZrMhb7jNRzt163cBEuADc9sVYiX9J3LZYXMF4egiW9uFtB3gDSdmZfCsmBjNxmNq5kN5PAxx7AuRHWQ+a40Z3asKizbZd+jVEjKMoWlAJicBX6j0iBLmCyXDUjd1WVeBG8I3LSkMPoTc5yjMaNjohmIvIJa6bb9zyRn1zDFGc0LAaqoH+9tE9y/+We5qtH4mW5dRfXSOo5C8tSaB8LjeJBFXk7+DnsCZBiYI2iBwbp+puiU/m9RnWkTiPwlaPCQErik0OHHjjcdarNDFdisQck8ObNhmMYd+80Y88FyLvRc8LwvcGjxu9q1FWTvOyUqhKjSvlmEb3Uv9BZOoxKsteWvIq0bvzBmNM7Ro4GDyDX9bO1Cos6zOr7To64uujbDdVUYiPJAIIpbgtdgyk3+FV4Pqar+Jo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(22082099003)(18002099003)(4143699003)(11063799006)(6133799003)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3V8ChpI6aF4GoIH0mU43gn7tZWB/6kKk+ESpyaqWxuaf/j1hZ1zi75W3GRf9?=
 =?us-ascii?Q?/TnqGT/qut+luaedZXu3Xp+Qv47BkvuXaof5i9iRmW1kqoCVgk+WXIbs4X8W?=
 =?us-ascii?Q?jKd3+mCO+NFaovySH0XMMOIvfja3IEx2w5WVHagz1820r6Xuv0YX9WntoQNz?=
 =?us-ascii?Q?D03revweaOaX65QNogyQJdh8NiGrt8WBfYmqYXEWQTlVDmMseN0QnYzrbYiT?=
 =?us-ascii?Q?jX/uJ2KrU1pqxG2XTqxBmMehi2MmQwyYNI4PQZjFFGzl5J9wyqHyBdj+LEjG?=
 =?us-ascii?Q?qwQ0GGB4CyZea6ZT5d2/41iEf+S9k6a7XW5pk/hMfJYf5vxCY1FPjtjecWQu?=
 =?us-ascii?Q?ygaPLmwMNl10U1+njML/aHNMent+DzDDodhF3CHpQdFytkf8ZHwZottxoeiI?=
 =?us-ascii?Q?PKDwHg1t5MDRnmK1aDm5hzd1rVB4eYJKxA0r2GxwVi8gjUJOWRuTumohUy6c?=
 =?us-ascii?Q?mxfSnOLR9dVRxumSdUDbDuuoFn+9M7BUE1hoH/U06RwflKWKdociAu9Hf7if?=
 =?us-ascii?Q?y50qUVfx+ADW4b6yOL5+ncM77mocZ4GaSOG/x18uW455dxUs8YzX8MRY2H+8?=
 =?us-ascii?Q?DcWwcqAKAOU4xefPjf67GlWX6rTn/DMAM7ygyBqkTGoQj3wGDHqFQyLyC7m4?=
 =?us-ascii?Q?LCWOdgHCgwjdKTmKWwiilV4g+2sdzjVoQFl8d6dKepfA05v4EwcdcNEnREch?=
 =?us-ascii?Q?FuxGwrL817QJCA54bIKjCFI9ODR9X/TR8/zgqqylH351AuBemJDgMxPApxlN?=
 =?us-ascii?Q?ASysOBKjdFKOWPViGlg9FFTHDrx/A7DP0JRPqg3U+2toHyAe1ZpJKUohGkcr?=
 =?us-ascii?Q?uBKE5Rm0hAj5kZOvOt/Jlg5cgMiVHwa7JrElgpsnWQ76BtxW4YUhY43EUe6O?=
 =?us-ascii?Q?ow6HBoebwQHERwZVZMv6mABOfzr99lvMUvTtT/r00FVdh9pj7OU+s32NZxNZ?=
 =?us-ascii?Q?eYLXT7cchYmUDDVERpyVeNlBC1VeaNHk/hg/tev/+BFL6oLsEhW5h1uYjipd?=
 =?us-ascii?Q?uUQZXhymn+8Kq70oGedQnRV7onVeV9zu8BRhuYDpf8Tn13rWRPsUMEhKAyMm?=
 =?us-ascii?Q?N0qkYUIcEA3zGZvs5jmB3pvZ0ae6JbQdxyxRgJgwaHfbMh4serVs+Aj9pwyG?=
 =?us-ascii?Q?PHNLrWsRO1yOaDa6MU9y9aCeeZtfDG4iN9pF2Z4X/EQ/X8HMowhSFyPSrpP+?=
 =?us-ascii?Q?Lh8+QZFdKN3ROyPg1pzD5mhIPksX3TUVKnwgUm2L1DnuklKQUJ3zjX3jykOV?=
 =?us-ascii?Q?GCnW/vT+JAuTGiZ5sLJkOuk1i1Xb3zKa4hUrNIEC5LnJtiGdHZp1lu/5V4UJ?=
 =?us-ascii?Q?tcngBk8m8Mch5hH+Eh3n7wOwbXEYLIeEedW4T03UIMG8/avjDz0l1kn2Gn6I?=
 =?us-ascii?Q?FoehsYvH5Eu1y6BUoeMnmAlslOUXCYt5FBDBb9i2oLLGgTJ+PHB4OqW5jKro?=
 =?us-ascii?Q?3Wtew9xgD4fY14bTf7w/tymtiuFUivY3zUj7cW6qJmh4OTiopFN3r7Xum5hm?=
 =?us-ascii?Q?TGPGAOOEVLeeb0Ebpl495LMkcZvjDQlrKdHrbT+GZ6TdURvDJ3T97mIcBSOH?=
 =?us-ascii?Q?/GRVQz8qw0SHLEeq3shuAv5b5uqwC1G2ADeE12rbtFbyZWsreLxnifGrj75E?=
 =?us-ascii?Q?wG23H0lE1SP6AQ6im4ne0hii+5BsTmRq6msMIsyCs2aKtw2Sy6Xa2JwmWTgc?=
 =?us-ascii?Q?rnXNk10yLqYMMDFLbIxee3vjHDX3BK+5QVi/PD5IYeSTX0+mUS4nepFneRP8?=
 =?us-ascii?Q?kkHb1F36yQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0706bc9-1c90-4989-bbf7-08def122a9d8
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 05:47:11.7012
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aj3rpKsF9Xt2yw2hRSCRQg4+xI1VRnXTxgo98UdyTOlXDcsRW7kavyM4KKMZn2NxxKBYx/MAWIxIBGNWCs9Z7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6853

Hi Tejun,

On Sun, Aug 02, 2026 at 09:19:48AM -1000, Tejun Heo wrote:
> Hello,
> 
> On Fri, Jul 31, 2026 at 08:23:33PM +0200, Andrea Righi wrote:
> > The built-in idle masks are reset with all online CPUs marked idle, but
> > idle state tracking starts only after the scheduler is fully enabled.
> > As a result, ops.init() can observe busy CPUs as idle, and those CPUs
> > remain incorrectly advertised until their next idle transition.
> > 
> > Enable built-in idle tracking before ops.init() and refresh every online
> > CPU under its rq lock. Once a CPU is refreshed, later transitions keep
> > its state accurate. Keep ops.update_idle() notifications disabled until
> > the scheduler is fully enabled.
> 
> While a sched is being loaded, bypass mode is on and when we get out of
> bypass mode, we set RENOTIFY and trigger kick each CPU, which, if the CPU
> has been or is entering idle, triggers ops.update_idle(). So, BPF
> implemented idle tracking gets the actual idle state update when bypass goes
> off, which makes sense. Would the problem you were seeing go away if we just
> clear all idle bits on load instead of setting them? The lifting of bypass
> mode at the end should set idle bits for all actually idle CPUs.

Yes, I think clearing the masks should be sufficient: it makes the initial state
conservative, so ops.init() sees no idle CPUs instead of potentially seeing busy
CPUs as idle.

Once __scx_enabled is set, exiting bypass arms the idle re-notification and
reschedules every online CPU, an idle-to-idle re-pick then updates the built-in
mask as well and triggers ops.update_idle(). Busy CPUs remain clear. The mask is
temporarily incomplete, including during ops.init(), but that should be safe and
it will quickly converge to the actual idle state. So everything should work.
I'll send a new version with this logic.

Thanks,
-Andrea
