Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010026.outbound.protection.outlook.com [40.93.198.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996C727F01E
	for <sched-ext@lists.linux.dev>; Tue, 23 Sep 2025 07:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758613534; cv=fail; b=LIcxinreaPqPw/hDUC0nUVoQqTJQ5enE1ttoniJWbvUfE9SLvZAKqqExR0Ecodx3prq6K01Oj5Ddjpn9YMyS+Y8xdxlkslO2JsdX95A4mZy2s/YLZ6RW+zuiYteXCLForIwHq83DrApnzUm5p8BbbOdlyHFqqDvs6FBbqUkbEJQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758613534; c=relaxed/simple;
	bh=+/M4HvruErV4jBnQCtcW5pa57okAh6ZZMgW/20bcihk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HW7yp+ywth3PTVvS3uj7grsyvE76qWuO/bMZNXvz07zYtO7XQKE3sMOsxfDB7GiwCz9M1EKR788TfOoE0s3YNI4johc6frH8NIz7XVeEpSCDoe7z2UxF6dIhCzRSa78MOAvfujUS9WNuiqEL9PLNWdJIjlB/Av9NvuYLe82ToGI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=l7ldCV20; arc=fail smtp.client-ip=40.93.198.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="l7ldCV20"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R8HK0G3xH9NRZHxUN2a0ze2YmPWzttA8E8/4tlCu2Xn9pInMKE9b+C9Lj4LrSs0L8j9frx9XRoYaWk3PnkO2S95LxgZ8Bhvf17qRi5X2x118ygjb0wTEkMsouNmqaINBrlPt3/mBj/qKZZfyXgRjJl1GPYZbLq8xU8nnciFDtYoL6uiWcN15xybQhT/TOMzGmpBaB8FuhtSsTvqhpP2VYHZUPhRlhB/FIResVp9xFLK44AAu/VvzQTp9mT46KLYZ2Vp5yxFqVnXW2+5S2pHoZdwt/nmLp9r+4QRfbenb7/dwc2TYC0OHs71e5oaq5KbDcgBvLpOxObfHiGwpJtxCQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZeN2vCBojHWiNmAM4k3hM5m23H1fWFe7Save76BtUXM=;
 b=rAmzQpaRmUPf6exF5tBxwosLXAjl9peYsMBEm42TaS20VU2hSsZz56pBCIxeZP4zt7YoJJP+rH1Cpv/3LaIPI35O9I+fhFVxxTr0ygDq5o4bTKV7PYhn04AN85zvEWkMgNeUh9+SPdZ9NFXWbaTUkNEgnpxSyPkmGIupY/2dC6vYvM8gGDJnrFmmOWC1WRptFm25/F2mvY/C+J7RyVWVl6gt+PkRNgbY0od5u02PiVu5SulrEP/NUgALYoAtfFeuEoMYqKDwvwoLnfUWOqawFlp4jrk6kwna6Pvps3c/Fj+uT9+EBAzPVQAVaxBx5Hm0ILlvKuKlDm4yZMvnz6vXpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZeN2vCBojHWiNmAM4k3hM5m23H1fWFe7Save76BtUXM=;
 b=l7ldCV20QzXfRmGy7oo5n9GpaEQMSqee/uHiRVn5kD+zdkCbTQrUM7iMprxWSItVCpQebycpEJ018Y1+AtEAFrGse7V3D346MYF0FQENgIvfCoWSd8x8aNSIwUk73pWtjwlvtdIusX7goqdf0htQegl6DVHEm9tYwrBkMYIyQfCoOCOplVkRvRdfuERToNXLTjyyy2pSUrgVOtgl94yzK9qXqy0s5rD2zhpW6nG3aw7YUzl7e/YtAXzvtf9Al9IuT+FXb9zi9/z01FYFVP8hoUdDflq8L+4N4MgyTrQlgjHgzR6nLjrPRWFWBfLPUC2Q+yKI8dmDQgt6T/jFISBYWw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CH2PR12MB4231.namprd12.prod.outlook.com (2603:10b6:610:7d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Tue, 23 Sep
 2025 07:45:29 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9137.018; Tue, 23 Sep 2025
 07:45:29 +0000
Date: Tue, 23 Sep 2025 09:45:26 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev
Subject: Re: [PATCH 4/7] sched_ext: Use bitfields for boolean warning flags
Message-ID: <aNJQFqg2R80VJc7p@gpd4>
References: <20250922013246.275031-1-tj@kernel.org>
 <20250922013246.275031-4-tj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250922013246.275031-4-tj@kernel.org>
X-ClientProxiedBy: PR1P264CA0171.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:347::17) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CH2PR12MB4231:EE_
X-MS-Office365-Filtering-Correlation-Id: c9cffe18-037c-4dc0-da1a-08ddfa752af8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vMKmSV/yU8Bj+nIzuatgf1wqOiYmT5CjFCvJGG9DKoMtQEodzhpn+XymRc32?=
 =?us-ascii?Q?hFfVCYexx5w+aTzT7Lx7IyRfDNhOCoodSNlk1EOeCKAKAk3t3ngEnXn5mLdA?=
 =?us-ascii?Q?YmQZ7atJo76Nb2B5pPErhI96mj09+Kx96KD+MHWBnma5E+DZYacAd7FV1DB5?=
 =?us-ascii?Q?h97mrh3T9YXl25OYMUVeFfZVCW8jRu1bcfXvFWR917gLYgvR1tDXYvAmj3KP?=
 =?us-ascii?Q?KPKVhH2TorggooEtQCx599+ZZPWo2TDzYqVQmD4veI3nKzSb9MnkIHSE6vFi?=
 =?us-ascii?Q?J9I73Ww/iDFvBaUgsiVW5ocXnLIKLvzK79OFmM2fOGb+g9Crzv4rZJV9d9Vr?=
 =?us-ascii?Q?tEXKA9g4PAyIi4CopjiwZuvJM9/ee6qbzDGzg5H2EsvlWM6sNQrGeGHwOzzF?=
 =?us-ascii?Q?e2HfnFLD9cpfqTWjYsx500IYSZGu82Ljb/bNF9FJHsYFgIyOzJmC6F4NbDAw?=
 =?us-ascii?Q?GwO5pBwv30hF0w/9ZFkkKP48IQpfQm+2NV4kYnLbWaZnHbP03vU5GlC9ZO4u?=
 =?us-ascii?Q?SDfkLg/4eDGCoi7J60miQhnCy6I5QjnW1+w7UYRFG6nR/D9ap0mLMYCE11RM?=
 =?us-ascii?Q?hzssrwGFYufW4wlgGrnWJ02tlM9+DrDw5FCvZhUbrV5ntxryLcGH+aOulavC?=
 =?us-ascii?Q?0poGWu7T1VgIcGqfdmmJBjRkD2Wgl+3y/iFbsdvc7YVXzi9Uhh9KUfMkSeZs?=
 =?us-ascii?Q?rBaB84Jd13gzuN4IkpuUh1/mDIi973L6JgsY1iHA4I3juVodTlun32bYNzdw?=
 =?us-ascii?Q?nHjkITQ6iEb57c8vYpUyMUmkNLzy8qbwqrWw5mc2u5MH6sB3byH9yLqqtNIm?=
 =?us-ascii?Q?YDxnXwcDDHV3/GxeM4z+4ydq5r5V0TRQd7X+69Eisda/EjQGFOQYZ+dpH8j2?=
 =?us-ascii?Q?jUDzUYT0wTYlkp+6+9UDI+tw439TFU/x2YRENeoBBm3A3vj5GIebjcTNutwR?=
 =?us-ascii?Q?e9iNua8E4njYeq0DaUnltTl26aG9M/Syb5GAs2F55hsghx8iXYmF9gYZNNHd?=
 =?us-ascii?Q?8cbJPvZBmwfQr7zO1nEm4gIx8ZdxDxVo+ClvSKhps+5kuH2AQd4kIw9gVKy2?=
 =?us-ascii?Q?vnVq4dKU6Qrb6tyZdFdY/I2R+kGjiwDOwu778jAcRLdfchB/8mRdtpPNJhWv?=
 =?us-ascii?Q?bH70TG6YthmICuLmm+LwxMJgeypfEdGeheQm2RghhH9Ux2s4svTo1quFoOYy?=
 =?us-ascii?Q?/jCraANummq6Azk9niGvzXdDii8wCwRJT93bA2B3LLoG+L761DPFTleLwdFH?=
 =?us-ascii?Q?p53hIsWtNFCglIXFfURM+eQWXnzr+MFFEvRVAPGp8Gmi6mKfIHjQiojOqLkb?=
 =?us-ascii?Q?eaqbDjSsSosCSPfNf94ygNBR0uyQ8yq81ChMS2ETgHLQKomb1tiA6mAWZuVZ?=
 =?us-ascii?Q?1GcxZs4bQGvcjRETCqTZ2YP+YoDParglvIQ1jr+ZYkI/G9NgANP4AsHCNXda?=
 =?us-ascii?Q?+WjB8Y3iEMc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xggFiPb1YIYpjB+BE3uc/0z+nZMs1fZSsxvR37VlIsN+yLD0kekHVyey2Acc?=
 =?us-ascii?Q?G7NUzWMTCQviTU/k3I8cyYu6fQ5XSNlM/sBOTdBvXXQzHSOi8Y0PbdhWSglp?=
 =?us-ascii?Q?qu1l+/PpiMpr2agizQYHSP7N6lYoF91KjrklOLzdF//8FTSJOjwwvOAkYiXl?=
 =?us-ascii?Q?5O7jkKAZXU2BC+DXU+Mtiz181RvTS2KOV/SUX/2cvu07mrSM4DVeq9NnLJHE?=
 =?us-ascii?Q?rllOdD80uO425zS758VGRQmcmcL/5s1cxUGxVgupJp/N1yohM84IT5BctsvW?=
 =?us-ascii?Q?5Lv/737BnXOh2Qoxws7QPFwGnZh10ttaapKWaeCGhya+HHkB1D7AumeWxkjl?=
 =?us-ascii?Q?Ww+vZQMS2jkGHsysmc7qCXIrzd/glna9ztK0iRjoPRU6iFCPwfEvsEZLS4y3?=
 =?us-ascii?Q?PiHWY8dlm16GLTq35nx935bdzchXQHeZpaBA8eMo0zVTeJViUEE8dNn9maou?=
 =?us-ascii?Q?N55JXfTQIEEcCTnA+Fng5Li1DHtNNR2Pacj+GstNHv+5/aLmZ9gN2hbzdcv+?=
 =?us-ascii?Q?1aedmtKs/NxsQ5nxSgzfIeT6vjXKYmGeBuq6gmzcOVwz+VEjRUIUlWvUrR5S?=
 =?us-ascii?Q?ePD2yHiqFFvnXqILBYAzWBD+Yt06bIaIZADRGfKVAbTChcyzAxgL8FHi0kII?=
 =?us-ascii?Q?Ke/d/NDailXTyTTcqUeF6Cj3BXemOM8Epn2FtfdMTZZeu7pWc138fQjT643p?=
 =?us-ascii?Q?BY9Hp2OBtKO8XDnL81TQ8zQyXXMahOw1FD9LrXAIP3F+GKkrAWgQ20OoSLWc?=
 =?us-ascii?Q?DwzWJ3Ecdz+jOfk8Od9wOBcT49a7Yaw/PIh+ZhK9PieZaIeEWYl0MjXCxuAl?=
 =?us-ascii?Q?2crBdeBMp3EZv4o43yL8z30NxBwib44FAgANwTwYAWy2vl06NbXUDh1fulVq?=
 =?us-ascii?Q?Asc7GVMDjIArviI5GwsR1ZX3KEu/W86+I170FGq9HQrCmIXosCLw0tm075hH?=
 =?us-ascii?Q?DtzpNUP7qbs3VLrzmVDKNvBG8YMnYAjnRDcJpzdqAke5/d9Y4GUFtdEop2WJ?=
 =?us-ascii?Q?BS/sunOHYgO+6nYKSZeaIBZefgdetujLuKAwHmJfu22owM6OUTsE+rONNyKF?=
 =?us-ascii?Q?abuwMe4QlEQ5AFmwp0SP39oQCZIke2xrcQtKzqmEpKYVLY8+RCG3SaeMsEoP?=
 =?us-ascii?Q?mExlqU0L2tkzHacOmLIMtdZpIZRZgoflz1ZV45tIB3ssgenUDaegUdPNvmtF?=
 =?us-ascii?Q?YSlIrzgm76I6iP4QnVc6ilMgl1SxEfHMqvNNxt4Sz5RhaWLm1Gn6VICdLRSQ?=
 =?us-ascii?Q?WO87ywukIf5jZPHSvYEjWnHCUExL6Mc0rYOfbhz6V9ZpYKKyUyGHzxVFPhZc?=
 =?us-ascii?Q?bo8l7n4Ppu7gzYQm0KH9NfpKrjTlo8bsQlTBWIp++vI4lkAh7fnPzDCONXIv?=
 =?us-ascii?Q?5VjCjHhrNo5rvv4MSheOJqGZc6Wx0A/LAaXz+ZFF2dh7E3QkhvGR/KqZwCTv?=
 =?us-ascii?Q?yq3VnabbYgdX+07AF8GFQWbfFv5NRKLP8rYKjZPqnoznVOOaPVAO0HbJaHSi?=
 =?us-ascii?Q?f6k+p7vCilTTuZsGYz4Zmy7y1N4EXihJ9oKlelYWdTLBT13GaWVoqdZPYHLZ?=
 =?us-ascii?Q?3FCrvHheitu4ZZqOwQndFd0yW0iPTAujl6WRNQ3B?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9cffe18-037c-4dc0-da1a-08ddfa752af8
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 07:45:29.6817
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LqHjk/yrxIOaOM4OMSBV7tp5IlYYRqqx4IDYozSszSk+gzpnVrdy4Tu1ESe3KQ+TVf9Q0znrbPaF9cfWVMeeUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4231

On Sun, Sep 21, 2025 at 03:32:43PM -1000, Tejun Heo wrote:
> Convert warned_zero_slice and warned_deprecated_rq in scx_sched struct to
> single-bit bitfields to reduce struct size.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>

Hm... I think the struct size remains the same, at least in my build:
 - before: /* size: 1072, cachelines: 17, members: 14 */
 - after:  /* size: 1072, cachelines: 17, members: 14 */

Maybe if we add more attributes in the future?

Thanks,
-Andrea

> ---
>  kernel/sched/ext_internal.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/ext_internal.h b/kernel/sched/ext_internal.h
> index 2e289931e567..1a80d01b1f0c 100644
> --- a/kernel/sched/ext_internal.h
> +++ b/kernel/sched/ext_internal.h
> @@ -871,8 +871,8 @@ struct scx_sched {
>  	struct scx_dispatch_q	**global_dsqs;
>  	struct scx_sched_pcpu __percpu *pcpu;
>  
> -	bool			warned_zero_slice;
> -	bool			warned_deprecated_rq;
> +	bool			warned_zero_slice:1;
> +	bool			warned_deprecated_rq:1;
>  
>  	atomic_t		exit_kind;
>  	struct scx_exit_info	*exit_info;
> -- 
> 2.51.0
> 
