Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011035.outbound.protection.outlook.com [40.93.194.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0484204E
	for <sched-ext@lists.linux.dev>; Tue, 23 Dec 2025 06:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766471990; cv=fail; b=ttthi8dPMviW7utlU47lzVrZIvP1WVx1BOzbPmefWquNrL5SAheBu18xFPJvDjK9us8ngmqhzx8A0OUh5+ChIkjGlGv1y04AKSGTjqfcCbLrLt69Zjfi1novoqDI2gD4cK47I6si/UKgwodEVTU+ppql68vmsoLSZXillQa3jdM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766471990; c=relaxed/simple;
	bh=PdchUOuUa4qCIPtdbUINJ+jLfuX+uhSlEtfns7WE6d8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MuVnkgWZC7NYQQXCmEKxmoGIst9HKfABA0U6xddpcE4BrjOuLpTx8ZQ79XdqsmBOGkqjpSJ35c/8P0WSccyDc9zzCBpezbh7bVss6M4RNTQgftKz82XFrYaO2aULhLhAZPyyRdr76raBbhCiMNzASRR1QETlsIUEW9jicEsUjW4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EmziOiT+; arc=fail smtp.client-ip=40.93.194.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EmziOiT+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dOuWsu/3q8N7Vu5sSi5nu3wdP0+e4l3naz+DpzG1iyqs1Gi2iD9NJTxTX86PTXv//qrJ47yVvCm6rHeNm7ZNhB4+xgiMS945zzQZuGy5MOz0aZ260QuSLFZGz3i0+7VVa6ggtvFsZJN1i5+k6We+Ar2SIcLg6PB42BMxjEWLJxWPJpgDv7S1QCGHNVQA3EWuAyvs3FeBcZxxSxTKKDQEf7ph0gzATQIRFaserbZl4Mfi5NGZpmuM9Il4ryCAhEn7lMSDOMeFv6t6zCDkxZ27l502qru/57yUl8neYM8E18sEZcBf+VErK8jn2pBIHuqUpUrMC4VxVNYltfq/inGIuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e3G4Bf9tif8r17jOrVNOSgfBfT8/lc5RBDxlPTFzqj0=;
 b=SdH0bB2cFx8hv23JHuR5bsVqL9XtfuIMFf/DnUBoKF6JI7u7CEmoFAp2Ke0DbbgZ8BXlSJr4eA0kgH9Pqt8ogPTPsIgHfGBhomQd1TaBe15t1r+2TRutriocBkjfDRmhP5KNBsO8CMqedb7I0SHLAoqZyEYifjuF7lNdMxtxM3INLL+ZShuaKyaV6sE25E8CgCrJ/j6uj+ze02pFtSX47n9PA70J4ZkEao/42rClfKdtYhKsTj2jiems35jKY0wrxt5zo1inByNKIWOxgzO1fY/vnI9xjviucFhUVegqtySQ4Zz3cuB5C2qXOdMIzeDycRWzYr0eIZ3HK/wUa/mg4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e3G4Bf9tif8r17jOrVNOSgfBfT8/lc5RBDxlPTFzqj0=;
 b=EmziOiT+1CXz4aiEtGMpQVN/Re/PUaZqqu4E+uuRgO2L2CPUFwyDvpN78KkvU0GLK/5C+laoWW6TQpFPoGjxy3KLQRYH5aLOlSoV4CDY+M/glc5aoWqahWmuMA3l8VRyAcxJOYc7F9VgCyIMSmvUJC65gse6qkf5oZ0mCmjpoYcSE4IxNzERtB6JX8MPG3uuiwQErLQhFVfBNEbjx+nwY/J72QXrIuUBQZwlKrhhKs+1nsGwewkQpFaXwkSJex/63bswHgs7VHFhbMgbEsuNBrY5jhmYdwlgDITM1j5qJ8/u3BBLU6uYScDGvNz9gRxnf1TkQBBZsw/7ugz2IaXYeA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by SN7PR12MB8771.namprd12.prod.outlook.com (2603:10b6:806:32a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.11; Tue, 23 Dec
 2025 06:39:45 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9456.008; Tue, 23 Dec 2025
 06:39:45 +0000
Date: Tue, 23 Dec 2025 07:39:23 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>, sched-ext@lists.linux.dev
Subject: Re: [RFT] sched_ext: Skip stack trace capture in NMI context
Message-ID: <aUo5G1K4uFC6YRe_@gpd4>
References: <20251223005038.62406-1-joelagnelf@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251223005038.62406-1-joelagnelf@nvidia.com>
X-ClientProxiedBy: MI0P293CA0014.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::14) To DS2PR12MB9615.namprd12.prod.outlook.com
 (2603:10b6:8:275::18)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|SN7PR12MB8771:EE_
X-MS-Office365-Filtering-Correlation-Id: e16b6b52-26db-4826-41e2-08de41ee0f0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aVS+fGRg2ndStk0JLfaSm7jcLe+vtQEoyFf6YLgs56bpaRC+m3yGMtXxMXHr?=
 =?us-ascii?Q?GQT6v0WL+fRWwiTBUuwLQvRKMn4esREqvjz6kRZCZsUNr7lhQ43dRXOaWiiE?=
 =?us-ascii?Q?WcbhMFkG44PuG5OauMC/RL6Am0ettLFh3bs6JBTBByQkMLa8+qu61c4cTyK5?=
 =?us-ascii?Q?BKVI4bTyHgBNMAaFfU9jnyCtULYvABzdd6gK0CZ5Myd/vRMhUnQZ3Nb+kOwQ?=
 =?us-ascii?Q?zJ2RfNtUYDgaom8QUDRC3Qn4DDjC04RV6iMwkELiIJPSiBxZ0vUpx3mnGPjs?=
 =?us-ascii?Q?Tr/4cHDZcPiq92+AQ1Kk54s4woAThNOpv99+VzEZCvOTbs1WzQKHM0Uxr76W?=
 =?us-ascii?Q?hLsfHcvlY1VbeXxOW91x3/8COpTQo+ie+f7ztAY4IpOaNmYvDSr+Zxrk1vne?=
 =?us-ascii?Q?Yb/xgOxSVzQY68JNdywzSIPNCMzUQ/gYcNuyQPVym97LRvG8xjWVvOvNBJkT?=
 =?us-ascii?Q?VtW6qOFiZkktJEp2GdhUt5CTEn2FNIZ5ziAtkcNsLkcTxo3sxb2Uh3Puc/Hk?=
 =?us-ascii?Q?hHUduMLZzF+9Q1SeG4UoT8FU/KISetoQtvhaFSh64z1dJRcVJBBbDZLADRTT?=
 =?us-ascii?Q?f255weprbzbiYZxI7NHhoFoS5/VGzTQAwSmfg1hB6vhjkdd5QEu7KmSur2QN?=
 =?us-ascii?Q?c9a+6h9FMU71Kilnai6kVjxAh03sdlorSBuKdbA7/r9+5rnhgcRJiNZb3jce?=
 =?us-ascii?Q?gO8do3m7UFPuKEEIsU+3nj7SXAm7PLbePmkgyDapD4ETZ6jl19yi6B02NTsj?=
 =?us-ascii?Q?gt/wr+80TEKbyP8cfAQ+jGay9PhexnEXBklb0I9dxfvURMZkpZLe1EVEOCla?=
 =?us-ascii?Q?5LOnfdb3LL7b2ub5SeiUMCJx5o/3L5bRC9TdnLYXurT3xy4beIBeh8B8OeSB?=
 =?us-ascii?Q?44hlRxp4y/3zEgrcxJL2WzvgB3cNRIpG4Y8sXA/04Af0Kv8uIx9PjSZm2qGi?=
 =?us-ascii?Q?C/3NteNdGZdblZhoI4sda0F9h2Cpjsek6lgbF7DvCunVo7YeqeiYMGa+IXG4?=
 =?us-ascii?Q?2FEDDse7DvZI5QWZvfcQ4frpoSHyCjQMgQPTEYtYkvEgFLTTD2dxVuId3FNQ?=
 =?us-ascii?Q?Wg4PY+h+VOyFJUG9pF67wiVVp+14XRcJmcS7wE+m+ugYSet4okoGry52qncx?=
 =?us-ascii?Q?wqsDX02OfxsqFawSyUObJoBuJnqiQ+piJ75YE1Jgo8vg1L7cRUhzduzbHQXt?=
 =?us-ascii?Q?ne8wdha3pYb9wwHzngjTVWd3OThDFFhvLq/PGOce/H2aq09ETan3KSEI0tgW?=
 =?us-ascii?Q?XZRUfl7eynJg7oPFi+JHCg7pNi48AwdegFna99kPCj+i4fRdKDUX5/g//xUs?=
 =?us-ascii?Q?gMQH3mAMzuBpmhx919ksJ90HQCoBkORCfd6lHKWI8w/Ghi17Sz7PlHLsWsf0?=
 =?us-ascii?Q?eUNHQ0/ovLgj7OJs1ela3X8bYRRofaJYgjvrQB5vQJg5FwcxaXHUgtgXB6U2?=
 =?us-ascii?Q?H5VUuO/rxVC09w4FgnRog2xBPfjKVAgR?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gPEtVBykw3ZPzUOgFudIe6M2THSosOZBDNLsOSr00x3PuOMrpviFlIkOvuXn?=
 =?us-ascii?Q?lPKR15gCnDAAplV069Dv7ziVNLmOFG3FyxyR0u1DCjJ+UgkRJoxbO7swmWcM?=
 =?us-ascii?Q?9V6sLhPDaS0MabjKwmO4OjJDh8+1PyozdbcUXlhovIZwv1yx3LGq2KO0YJfk?=
 =?us-ascii?Q?o2vHlomn/IrekggAeTF4gjB/gQhJ5dAg1eDDxXtmQRaNuq1a8g7aL8vRSLfc?=
 =?us-ascii?Q?xRjcRXGC6taXOw206f3avFF6722BxkQUjdAXbFoxpL9lj05eIWoJWE80u7WI?=
 =?us-ascii?Q?ZS2nbJ0wJDOvK9wLa2Fo0X+sHmiFYR2yHUEvZPldoZEJsLs3GNwGFv9sItZR?=
 =?us-ascii?Q?rTU0Hv3zSKlJmlvZzJ3jmOi6TzBZlaF6vOz53V4Pzwmr5goOlQbVrqCceE3W?=
 =?us-ascii?Q?0oiQFEu+z41Cb1ShD2whNoap5ZJ5cAHhLJkMzSDsYUCfQq1hz+abXdMzUrN5?=
 =?us-ascii?Q?5qJYF6kjvdu9E2ZlwEgISwCIuPpVWIHkTLM0ELpOTGH1Ksrv9MhgEVoXjAvo?=
 =?us-ascii?Q?OFH9Ei6QMZ5xplPwOX+cnhdCNgiEmj85SXPfNsGFvSQ4LhXEWNXGq1hhhjCh?=
 =?us-ascii?Q?QoZt0di3wAwWb2j5vmLpDyh/pUn+g4j/P2rqeLQg3r0XyVKd+FLLatiIvhyx?=
 =?us-ascii?Q?gKNi2ZhLhzfyKo6dUF1bW4RFxh6DlhmLLPAlcogx/6B7qUkSJxCRjN60+JGC?=
 =?us-ascii?Q?oBEMDI/hnWa/G1EYZ/F5kGW7BxCfaz/eGjFc8tcHDjUHnc/FkhVaG9Tc3jLF?=
 =?us-ascii?Q?p9AXBOUMEt5Gem9uSgKHHYDKyzqgJvu7+kYPn1GG5J9ipU3j4rDWkzol3YGT?=
 =?us-ascii?Q?GTmgCz/2bVqNaQSSKmZoPwab+04UVNPkBALU8vv9mFNnGt+jSr1X14nGwJE+?=
 =?us-ascii?Q?BdApnNOWvCChOm1AP13ozwp7g3kQaMH6AZ+9oKFuOJCAcUi9R9tOhqSvC1QH?=
 =?us-ascii?Q?wGFLXIudPSKv2lOh9PndSMd3x8lnblDtDkjvgCHtbtMwNLqdZQh3ug3JFdmb?=
 =?us-ascii?Q?usZ/USGd2HLVJtadsWYYtlL9WMzFRnH7ZA+sg+DIVTVt9gyfL2fsBbrIOyPp?=
 =?us-ascii?Q?J8gyY/r7rC+Llz1k1FlfNkPtQNU/qfsgcopu8pWZGBYIWDn6lPcnxnCjaA2b?=
 =?us-ascii?Q?NF6Fq6rKLtuUUEuEHC+eEzbN1bfHhOMCLiILuY2kjvIZa0Z4L1SncEbSt/KZ?=
 =?us-ascii?Q?0GpStLfUz24Ce10tdnjWs2XGdiCNvGlmyUvNBFKpzERuaOUXyikynr9WT2fk?=
 =?us-ascii?Q?eYLlljmoh3aP9ns2OOZHW+2gk9cUE18KcqT+OuGCq2sKEUeutfw2N3E/St/l?=
 =?us-ascii?Q?LQ69MqBeMV0O2dA7bhuAf0utJEZoDm68WhNPDVoeuesriRIr1zrH35DWOqNk?=
 =?us-ascii?Q?Vi/fYaKN4AairHkaHlaZcKHZFN5FGjIlet0quFDKQh8IdYzEQPujscOk6IlK?=
 =?us-ascii?Q?qSU2ZcbCubaEyWeO1J/LiWvvrQsvbBXZt2vU/bPdCWEBsnTl+TzU5++MtkNc?=
 =?us-ascii?Q?o904UTcvZG7O5WxGrUWcfiYWIbblBiDXE820yxyaMEuyb8QbqvrkZ7fQzp7v?=
 =?us-ascii?Q?a/lfLRE/kRy5hXtXDPlOVGTKsgKRTh6F/g9KNKyLr2iLzVIYaWPxkj8qg7CR?=
 =?us-ascii?Q?6t4qLgiISwOevmrVKRTJHMCFiNPUbmdyldcjqkFTPRbre2J1PTvd8LDGoUUT?=
 =?us-ascii?Q?UlqTlzXS1aLsii3bTox+p/T5bWVBL87V4aUhCzhUu8wwqYf3iS3v2ATkVU2G?=
 =?us-ascii?Q?DvwIYHPyqg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e16b6b52-26db-4826-41e2-08de41ee0f0f
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9615.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2025 06:39:45.3990
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ytj0WC685a65X7At4IM2kFw5Z5/qLMPCZwbmBPZjWNc8il+PaG/hMGk3JcRIbUTJi3Z4axbY4dvJCXsWnTmzhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8771

On Mon, Dec 22, 2025 at 07:50:37PM -0500, Joel Fernandes wrote:
> stack_trace_save() is not guaranteed to be NMI-safe on all
> architectures.
> 
> The hardlockup detector calls into sched_ext via the following call
> chain when an NMI occurs:
> 
>   watchdog_overflow_callback()
>     watchdog_hardlockup_check()
>       scx_hardlockup()
>         stack_trace_save()
> 
> Skip stack trace capture when in_nmi() returns true to prevent
> potential deadlocks.
> 
> Fixes: 582f700e1bdc ("sched_ext: Hook up hardlockup detector")
> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> ---
>  kernel/sched/ext.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 05f5a49e9649..a96255ca3a08 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -4678,7 +4678,8 @@ static bool scx_vexit(struct scx_sched *sch,
>  
>  	ei->exit_code = exit_code;
>  #ifdef CONFIG_STACKTRACE
> -	if (kind >= SCX_EXIT_ERROR)
> +	/* Skip stack trace capture in NMI context as its unsafe. */

nit: s/its/it's/

> +	if (kind >= SCX_EXIT_ERROR && !in_nmi())
>  		ei->bt_len = stack_trace_save(ei->bt, SCX_EXIT_BT_LEN, 1);

If stack_trace_save() isn't NMI-safe on certain architectures, shouldn't we
fix this inside stack_trace_save()?

There are probably other places where we call stack_trace_save() without
checking in_nmi(). Making stack_trace_save() handle the NMI case would
solve all of them.

>  #endif
>  	vscnprintf(ei->msg, SCX_EXIT_MSG_LEN, fmt, args);
> -- 
> 2.34.1
> 

Thanks,
-Andrea
