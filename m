Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012064.outbound.protection.outlook.com [52.101.43.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2D411CBA
	for <sched-ext@lists.linux.dev>; Sat, 21 Feb 2026 19:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771701879; cv=fail; b=krH7/zYiAqWNWatxYGkkSGC4g6AzF5Nh7xnpdcW1BacGrsMVgqITnZU8OjHaclm1z/wKkfzeKBgkNIJncD2WPWNWhvCxC/eyUqKWUM4sBFYtjQGI+sDe4Rb9r7CpklnHdoph1mxIj7IMiwCG44OVD7sru4HYpDBtxzx47FmWiwg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771701879; c=relaxed/simple;
	bh=PT3NOtnS+QGhty679Z5t7hoe+w2auKX1YwqjyQreVUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ElEV6V89Qcot7rOcVEbAVwFiDcg6Fx1s42SZrLqca2JBCBjclEgflYoXxpfqgQ0HlgCbgtE8YnGSKHINULXrhedDEjLifsrQGM3TaYu7yW9wyn04wLpUeHkIdTAObhhfEet1+DP4AEuIEi8dmR27SFhwM5UzrtYxPDfOIpLTZCI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=I3ENp5wY; arc=fail smtp.client-ip=52.101.43.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="I3ENp5wY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B9sQFo8Xds8cGhyfBjbEmS6+0yoaTRvZdE5my0B6XnjX7zRLR7quY1aBzZkIurH399evLYzFp2CYzvgQk+f2HZhWtd3RoUYPRDa3Oie6jg6HD9RiID2n0d7y+r5rD8K7XE+wNzeJOzaLjH0l4e05nNJNya7bp1sIaVDaFbvhuPSjL3XYyLB796P3oIXxY65ODMnGh43RjM6nbBRvy5+AP9q+PvW2m4VgnJ0of2fekqAi9zTKr4niUBNH4bwkgtSBYbAYLpZd/IazbxgbDwE4/fu19HXa6xYBtXIkSFdTm5Xc31WWYjRWTkSqz4Jls9mUTCJd8ntNjTjJ5KYqFLIu+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Lu866AdRzvaPCS8uDHBti/+a8EorwrJyEAaduxt3Y4=;
 b=h4EMXs3uRKQF1dWiYJIY1g43bMrPTOutpB+BoRca55y+0Mr2AEuWSgt7cVXwu+3t0nhpqJVN2f6vuFOtgnwa2XW5VXiWa9dvfB7RCKBUw6xByKvMEqdS61Q0uTtl3Tfd+VIJaHCwo4drB5L1xmHsbo5iEBtUWRgUwARGz/98L9bM1IoSIKTDfjga4YALSSQOvNxQSPbWmonHxoPaCL17F7urD8vXLHyNVWDCPFIeJ52hsPnIGTA4R7OzblL9941jT7ZMXuoykwmMHQwu3LdltDtRjTzObH97adqTpbaIdzBU1p8//tVek/Tvp0gdRQvS52pRxMLqrlNoh97AvQJkRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Lu866AdRzvaPCS8uDHBti/+a8EorwrJyEAaduxt3Y4=;
 b=I3ENp5wYAenOTPFLZ6u0MttHl8b3zF9vj1E07JmAffoeZNdu7YmJCCHV+d4XOsvfCaMUEx68DVVVsUz92w9kxc4YFhbQgpiqmN032PcSvBa5wiFlJmW/gF10z5P+KtZyi5ksUs5/PuqPgZgUyNHQmXiBASLPsC/90Nh6IutlrSGR0eFQAEZhc9L8bUTgQpDBnWNLH06cDwUBApWLdW/1z1z2OAuU6XVru3rwoku0vFJ444n4ggoVRTylm4EfbY5FDo1w0Q0RqP0aKOhvRgZ2D4qwApRrGTevmdYblu5JuDUMrkT5Ys/RgF/tpmyjJTAxYNaPwQZM4o4Qt+Om56eJ2w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CYYPR12MB8922.namprd12.prod.outlook.com (2603:10b6:930:b8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.17; Sat, 21 Feb
 2026 19:24:35 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9632.017; Sat, 21 Feb 2026
 19:24:35 +0000
Date: Sat, 21 Feb 2026 20:24:20 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Cheng-Yang Chou <yphbchou0911@gmail.com>
Cc: sched-ext@lists.linux.dev, tj@kernel.org, void@manifault.com,
	changwoo@igalia.com, jserv@ccns.ncku.edu.tw
Subject: Re: [PATCH] selftests/sched_ext: Abort test loop on signal
Message-ID: <aZoGZFr9oirUg6qg@gpd4>
References: <20260221154042.1171011-1-yphbchou0911@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260221154042.1171011-1-yphbchou0911@gmail.com>
X-ClientProxiedBy: MI0P293CA0011.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::11) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CYYPR12MB8922:EE_
X-MS-Office365-Filtering-Correlation-Id: 68ee025f-314e-4377-4bd3-08de717ed85b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Xdj5IDdEaEgjfMQGlU4tfVBka861H1XWkFe+yDYIk/NFCPqJrAjpa29zehjV?=
 =?us-ascii?Q?g1SZVKWmMUJFZPXfyujM/+gDiDOAYUzytLXlSXU3lLRoR0bQEH/ooRIx/dgF?=
 =?us-ascii?Q?MQJirPY78xKemo1q4Ih0ZEQoUPKhCrDcQTBoSBCUTLhv4j+9Ct3YU3qXiH2z?=
 =?us-ascii?Q?nvYSaN8QuhJVRfUJydmYxqb7filb0V5vh73MMJdUPDhJPVkC1MoX8o2IHp4D?=
 =?us-ascii?Q?X4HYA2wi9acK3hoi0GSDm9A+a0Jb1MN//sl2qDzw0K36EcIbPLoHE7HQeaQ9?=
 =?us-ascii?Q?vmXNCUqpYJicqMUZBo7JhmhjwQ3ALh1IDOeKecjleLZLQJsUXd6EjHsdDU7o?=
 =?us-ascii?Q?WzAs/xsN8PMElwwUAs49swFFz0kawsbwi6SRW1XILViqq8iw+KQrBFlsTZCx?=
 =?us-ascii?Q?vqPDokSVE2ta/HbcjIUd7qCkiwvpQTnv06/Yq745ruxNP2xwjkMR3yKaFcA5?=
 =?us-ascii?Q?RY6o4id2MG/yjcW9CbJgYnX8UqL5Wh4Bi6ypzrGis+LxRs8KgSrfX+BIele6?=
 =?us-ascii?Q?r7aDYxXr4eoBkD7WqOC7DtoSZ5jElgI9xdNIEBkLDdkjHmazsOh3CcVmv7wP?=
 =?us-ascii?Q?FGFnSjWjZQS9MjgXoLPFHU+NcKfVzZa8loDVINzWZQ+q3O3vcg0hFmBF8S/B?=
 =?us-ascii?Q?R5u625h05zdPnDok7glSCEgp6YK9NtvbZHbau61/HfkJhqErd8samatbWfCH?=
 =?us-ascii?Q?8TCfwWutdiFalhzEjSTR3p7Senylm3XPKtTOVm1AHIoLlqkE+VwoYYRO9Kze?=
 =?us-ascii?Q?6u8HMNp5B671OZ11SAiNHobCntGW9l4PJnQ2yPjLSOdHILRpthEEK00LWEPD?=
 =?us-ascii?Q?YmPQE6WXs7cy22WRh3urScRA0+2+0nM+UpRWAYnF9r8ISd3fnZd/Q0+07UkS?=
 =?us-ascii?Q?GkWEsIIhbJ42E3xpKa8DZ/veeJZtHF8PQuhHTMu77X8vfQV7ROah7+XCUnRF?=
 =?us-ascii?Q?zCf5vsrWHJcYpX4Jbo7Nz2YR0B6yrZaNCi56+GyrVeg9ol3iMReMXH6RkLZ2?=
 =?us-ascii?Q?G3/A4de2buBl0fSC7prdYA00eMyX40W20w9vXbib6dGThP72KC7DEnV4ytEZ?=
 =?us-ascii?Q?pcsSKKU2MQL98IReRoZE1Xw/dHJgnRa/kd1y0V9Dn/O/23c9Rj/e1qBBlsAu?=
 =?us-ascii?Q?mg3as2fS8HNwZ3GIo2+oL3TnYUq6k4zZt0nD63RNzCdQI0o4U63X+Hg8vIdv?=
 =?us-ascii?Q?Kfme43ZyoAafoJquVXF+06lvxvPTDpy6iQqC5VkKKeAtQmv0WEhB3sk6tbdz?=
 =?us-ascii?Q?xEYiZvNt6NUHedbTWoPlCNyNMiPYROdm1A214AzmgUF40upzX8P2tSlMnA0C?=
 =?us-ascii?Q?ZKu4+9cfA8kMkUeEU5rE9Ke5S7Wf8vvBo7PRAXTWJc6kYVo2gWCsMVP/OTFi?=
 =?us-ascii?Q?lSLApSSkW04wfhZ5SmM8Av3JV8aCcRnE1N80Tyja0ENp40AsciXiaXi2iYLy?=
 =?us-ascii?Q?hCpmd6M3o/V8Zty0s2Y/WXo/gAHS34KqyX1bNEAZ2R7K1uOI4brOAsMNoJmi?=
 =?us-ascii?Q?eo68Tvomf1XGnXC4iY4+Wp8Vq7eaZQHWnJpZ2BGpsaHHtbecDgTHdryRl5ip?=
 =?us-ascii?Q?KsUwjSFW69bxAyTBwZo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lAaKs52p8l/0kVHqBC6bYW7tQWG3U30BLHcGeHxZrjAUP8jmn63pXrh8X6gu?=
 =?us-ascii?Q?JE1ReuGbuk301sVaGQfPtwJirt+e3ExPeUqe/7lWFVBzrKTcdHgAsF7/Cziy?=
 =?us-ascii?Q?AKFvOczFrsbfEMB+zpXs3T8W16MeXjyIk5M1oxufWt7oWQJPkt5WGfLdjcfZ?=
 =?us-ascii?Q?eNcrJ16e/F4Uer31PFloA84ZXhgpo6rIIhboG0lvLTib1/t5bMu8vwto0Xu7?=
 =?us-ascii?Q?6YpDYarioourPElSlSigqN6GxgHLPFf3SgJZwOEKHCYMdOn3kwZSJr4NH3j/?=
 =?us-ascii?Q?WkpkQWZeXCl0NWBl5JyPyluYQiYuxg70g3cvcZhYyA1ixZOnt+V5w8RYSpPX?=
 =?us-ascii?Q?G7/akIbtVrpFq8kkq8sjaxXcKS6jiDWY5Fyb99oHcDRT9lRFT+99AGtxlM7c?=
 =?us-ascii?Q?hslcfTLIrO9TRoVb2iS6qLeQK54CGi9Ibyo+Ph3ym6tJqEWall7GOsZAYkDL?=
 =?us-ascii?Q?gSWFxdk5UUDnJPiIRYRqe2+bGRpX49gdWTnm39qGcdOAfsuYPK4BJdAVOvDl?=
 =?us-ascii?Q?CoHRXNQqyxwLDYTVC8r8a8qxKQ7n0fyIXqXGP9D0iOAol/6MkTkLv1/LnncX?=
 =?us-ascii?Q?RMnLdMS4l8mAZmMwfL7jkrgb4xD5sjqljM9aGI4DUWcnHUeLeY9vUeUq+Jok?=
 =?us-ascii?Q?ys7EB9z+B2R9VqReFtSIDWTMXAl4Vlsw2797F6d5maaN2wsETEuNdTeHCUBg?=
 =?us-ascii?Q?Gyotr0Kscur0N1qUnFoKmTBqrbtWjvkLGjHCxiZmKXCfB/IldqgIzbIR7u0u?=
 =?us-ascii?Q?TDzkbPTH47l8/Pc3yJdTveRgyWR2DX9jCZx85Kww7J2w8biQGI/IORB8PdaN?=
 =?us-ascii?Q?7mHYF79BBxYVw9NSXV+l/KmuJLH8gAcB2GMifVTQnd/ABlZFmDmjZI4RVXzn?=
 =?us-ascii?Q?CaQC9rDeFTbwFMo2V7Qc1Gxo2Lm+daPpwbiUFspoa3r5GJB6SrGD0SwgD7Zn?=
 =?us-ascii?Q?5el5j4faBPqFzlXYGB89StwTEt84vOypuQxUGHmcA4xFwmB+Xf66twvvQtO9?=
 =?us-ascii?Q?OCmdg7UbukSMbLYsGw3RPFi9zKgNK7g4HSNvfUkurK9UWh3IoLRI1EsfTh+U?=
 =?us-ascii?Q?aRYC0EdYfC9R4rHwz0D2qv6gFltbZND1xvvYZhsT5dl866KPeXs8oBa/iMI7?=
 =?us-ascii?Q?EwB4BlpnIVrBKMStberB2tMhks1tc6DUViMCg53tHGObWGfRsO7G55OiKySy?=
 =?us-ascii?Q?j5NJRWUIa0Map67H7HVK13/jdsLuiMzmG7VI9gN+AmGK/lsu+hvKNINIoKtC?=
 =?us-ascii?Q?gsBL/SJnzhK8aLQdiEyuAmOYCjENIhqniCGId0ZQucEoZA2DAA0uDd7NzN7D?=
 =?us-ascii?Q?VhTQnhLTu3OJv0FF1ZQXijOwZJoaLs15AxaXtdn0+0xAN1U5A5S1LDEQLN01?=
 =?us-ascii?Q?mU7JaZ68kr9x7esAGUNtQTdo9V0yVWTHD5SkgiGdYtyxmgziVao3l1s4Alge?=
 =?us-ascii?Q?Mu3VimTwxhWnPAmOWs9U+shFFvFCSJ2Yf4R34vrNm6/DEhL/JT0wKjwTttCm?=
 =?us-ascii?Q?PsAbqvbAP7h5kcPr5yCvcB0J2jQT0RZX7BYcx35sbyY12PjKPl/XMdAt3rXa?=
 =?us-ascii?Q?0chPP7U5vc1eZruRnIBHKuWJrzcMJdUJwsqgnFfVkExbEzTOqyaxAoXvR80d?=
 =?us-ascii?Q?MurazlRPQt1FzoKY/oeZ+JBhJ9Ka9+73DrJ0NqvmIqLhvGbTKOyQLs9fSGEI?=
 =?us-ascii?Q?TRBO9VZky/cqHAmzbYat1EKWCNuLMI/QqRj8OoWAf07y1G0c?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68ee025f-314e-4377-4bd3-08de717ed85b
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2026 19:24:35.4049
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: forxxVKG7zbWr6FjA8b0ON4vmqwxSgYNGvMdKEDAUxyV26qNZCDBHro1U3hMWIyx/mEdy55HSsk49HoD5xpGhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8922

On Sat, Feb 21, 2026 at 11:40:42PM +0800, Cheng-Yang Chou wrote:
> The runner sets exit_req on SIGINT/SIGTERM but ignores it during the
> main loop. This prevents users from cleanly interrupting a test run.
> 
> Check exit_req each iteration to safely break out on exit signals.
> 
> Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>

Looks good to me.

Acked-by: Andrea Righi <arighi@nvidia.com>

Thanks,
-Andrea

> ---
>  tools/testing/selftests/sched_ext/runner.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/tools/testing/selftests/sched_ext/runner.c b/tools/testing/selftests/sched_ext/runner.c
> index 5748d2c69903..761c21f96404 100644
> --- a/tools/testing/selftests/sched_ext/runner.c
> +++ b/tools/testing/selftests/sched_ext/runner.c
> @@ -166,6 +166,9 @@ int main(int argc, char **argv)
>  		enum scx_test_status status;
>  		struct scx_test *test = &__scx_tests[i];
>  
> +		if (exit_req)
> +			break;
> +
>  		if (list) {
>  			printf("%s\n", test->name);
>  			if (i == (__scx_num_tests - 1))
> -- 
> 2.48.1
> 
