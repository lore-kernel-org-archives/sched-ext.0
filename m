Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FDB4282F02
	for <sched-ext@lists.linux.dev>; Tue, 21 Apr 2026 15:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776784896; cv=none; b=dvPHQ3enh9DdT2Skqx8MFdjQenzfKwlZPct+5An7Zf5pB6eplyyJDwlWU2qLN5Q6uqxLTFfacSnkd7Y5ZvCgr81+EWGjaBCzEQxhvs3MNa3rtv/aAtTiTEvGwcfQWQX5B+6F7iMJAexmqtVaswt4ur/ZyGi/9gpRh0AUOTIm+aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776784896; c=relaxed/simple;
	bh=a3ekt+vSixlhpbGWmOPS3BDyGmWCQJinYtAubbnfxV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DBEOdaWdzbWCGdyaaBw9PDuFqo+G86PfUhPO7n9s9k5AHzZO1eTepS/pxKHsF0BT6CN7j93OGAZNmw1Gy0Ud9eOOYWWGU8Uc+XfBVmtsyS8i19Of1UZhZfnP1w4U1maIl77CDMTnnCMAVBP7CZD4GzIETUT5hvaLLXaaVnMtLNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PAvsKEA9; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PAvsKEA9"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3567e2b4159so2980649a91.0
        for <sched-ext@lists.linux.dev>; Tue, 21 Apr 2026 08:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776784895; x=1777389695; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=05Fga0G5Evy/oPW0UE0rdUCl4SFP8AzT5VPmbIVFF6o=;
        b=PAvsKEA9fVSJrhUpjJ+Hgn1tCxEUsZWAcsvpoAujK/DWBLaHdErnk7Corn3g8yhZ13
         IYDB56KJ7baDlCBpoeid7mhoNh6dD65AKdHn6lYcC+Golx/55hgzdYtC9iMruYbI7Pjy
         u0P4I+y8Ck5/tfnQxHd03fhYWH74GImhfZbLB4J9c/OHYAV6M5mNNd17ZpDTtLLSaHGf
         X4IMtx/ls5MnM3KtAS8/gj1FnLi9BuwU1pRZpBMLQ/hfpL0DhQRrBv4teFpoF0PkDDl5
         sn24CNPP1tjyszAc7M077QopfWQFXj6cywV5lRRKNhVPVC9bm0Z4KhxT9gKtu4yMA26O
         zw5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776784895; x=1777389695;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=05Fga0G5Evy/oPW0UE0rdUCl4SFP8AzT5VPmbIVFF6o=;
        b=iX9civJT2TAJHpV7DZxXcEDhlMMDb/5fIj7rWJMI/pVg4a4I4i0j/9We3kVB3EFZU3
         /ReHT5Vrunpqfn2LhoJ69WUHBF1zQETf+EX0768j9JSLYbT505Ozb8wy5ZnMrHxVCIH3
         9c90Qe7gnPrtUXQN3KxzUVAv4Rs3xMnLrUZN0V5vWQpEaWsMiQ9iEbootMSKVKov/WvF
         eS+NDhnku+YykfRFB/dAqQj1LV7rh79rPPR/gD53mbS7IkDlH3qzhbdW+EjK3m4BYz8D
         W/CuIKgcSUykW50/pAhu4zy384m2BA1OWLoB4BiUk6GopqHLsmSvncAkCuZ1UP0mHpUW
         PzsQ==
X-Forwarded-Encrypted: i=1; AFNElJ9m6E0aN9t6seadSHkHHYiWacxfjm81imvlbOyzWV1ZLJq2OKhOEnpvg9bZsdNhBcaPajuaqSzpd78=@lists.linux.dev
X-Gm-Message-State: AOJu0YzChJAF3gQeYLLclmcX7hoZra+daRDQPMPKaZmqJAE62Kzf9Ker
	8asL7iB+xWPNNV6jx6wjbYyfiBeztokzUub1i+iZntVKpr/wl59tq2sY
X-Gm-Gg: AeBDiesFcp0NQ/MHYeHijrgbb9KZojgE6madwPvRXvdI9BSysqlk2lFOB/ih1G+voKD
	qC/9hony31pkTeUPIVkNRdRg2/y0GYYSw8AJRCOfGAxGSENhrGEC6NE3CpW3YBLJswZaViqjNy2
	1Q8YCWTcQU/ymuL4G+CVZypQPufuVvCTWgBIKxDbiqq/Y3dNHbQa5fGCxyiU/dQHmWgRr6Qn78s
	95y3MDvTI2cDMekdvcHEd9wf6ZnK5BUAmag4rjp+eMnIQYL5tR3xKbE/v84jfDjHPSI0jWWPzu7
	B0SYeKu/cim9vXqqW5Rh5+Qcf45dRsG9BoIrFw/w1ngqV5kjtXoXc5FBvNy5AF7wanfs8r9suLe
	MqINU74IdTJYQvFCoXrjx0LOHQH/rFhuNgU3Qt7N10pfje0UxMsApJjVSfEgBWD0RiAYdoeWElF
	y5LE/qbVjvek3UNI8i0SGy+DNI63f+8hDLJ5vlysu2KitlUC+VpHwvdLkOPpyauWZc3ttB16sUG
	mnAgsZ1gBdkk1kE
X-Received: by 2002:a05:6a20:7489:b0:3a0:bc61:62e1 with SMTP id adf61e73a8af0-3a0bc61653bmr12722140637.30.1776784894628;
        Tue, 21 Apr 2026 08:21:34 -0700 (PDT)
Received: from cchengyang.duckdns.org (36-225-97-241.dynamic-ip.hinet.net. [36.225.97.241])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36141990bb6sm14492884a91.17.2026.04.21.08.21.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 08:21:34 -0700 (PDT)
Date: Tue, 21 Apr 2026 23:21:30 +0800
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: Tejun Heo <tj@kernel.org>
Cc: void@manifault.com, arighi@nvidia.com, changwoo@igalia.com, 
	sched-ext@lists.linux.dev, emil@etsalapatis.com, 
	"linux-kernel@vger.kernel.org" <end-of-line@duckdns.org>, Ching-Chun Huang <jserv@ccns.ncku.edu.tw>, 
	Chia-Ping Tsai <chia7712@gmail.com>
Subject: Re: [PATCH 06/16] sched_ext: Add topological CPU IDs (cids)
Message-ID: <20260421222648.Ge916@cchengyang.duckdns.org>
References: <20260421071945.3110084-1-tj@kernel.org>
 <20260421071945.3110084-7-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260421071945.3110084-7-tj@kernel.org>

Hi Tejun,

On Mon, Apr 20, 2026 at 09:19:35PM -1000, Tejun Heo wrote:
[...]
> +static s32 scx_cid_arrays_alloc(void)
> +{
> +	u32 npossible = num_possible_cpus();
> +	s16 *cid_to_cpu, *cpu_to_cid;
> +	struct scx_cid_topo *cid_topo;
> +
> +	if (scx_cid_to_cpu_tbl)
> +		return 0;
> +
> +	cid_to_cpu = kcalloc(npossible, sizeof(*scx_cid_to_cpu_tbl), GFP_KERNEL);
> +	cpu_to_cid = kcalloc(nr_cpu_ids, sizeof(*scx_cpu_to_cid_tbl), GFP_KERNEL);
> +	cid_topo = kmalloc_array(npossible, sizeof(*scx_cid_topo), GFP_KERNEL);

Since commit 69050f8d6d07, this can be:
	cid_topo = kmalloc_objs(*scx_cid_topo, npossible, GFP_KERNEL);

FYI, https://lore.kernel.org/r/20260226071913.GD12611@unreal/

-- 
Cheers,
Cheng-Yang
