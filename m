Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8CC72C21E8
	for <sched-ext@lists.linux.dev>; Sat,  4 Apr 2026 06:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775283256; cv=none; b=tH2RhQTDV2smuCulcTkALdH4O7tWPAVsixp1n/L6bmZ95M60wZyhdQHhxVuNUhemrtdKVZu8tw4Aoqjv1rY12D5XfWLmyNQHB7qCOmBO4xkpGRMR8xJSWXlefOrxfQHCnxqwg/nhmsGFxzDvOWeYg5fPRor5bmOeLbwzbfVoLlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775283256; c=relaxed/simple;
	bh=OVT/kgykoc2TbeO/I99Xdvlwl0+3L5yHpy/6DmpEHLM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o2BibtPbrPKSk+5OCl4oPnm3zEJg9vP9Azq0pJ2wUbyROWKGP85k13dSRG9auAGKheP/uITi7heMXTCvzIxyPAVI/Prh41RS1NJQRVvpmhs6dad49iET5KISMvd85nSk3EJojtKWF8elUnCvS+wSKV15tF4m5XsnwReXguq7+Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ci7H/Gt3; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ci7H/Gt3"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-824c9da9928so1564882b3a.3
        for <sched-ext@lists.linux.dev>; Fri, 03 Apr 2026 23:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775283254; x=1775888054; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=enGTakgRN45CpVmSp18YlLl+ReZDJx7Qx15kC5S2n5w=;
        b=ci7H/Gt3j5rAFdTzMpILY2PrWwGsN3xjCZ2LmimesOQ/+WgLbwOLnW3UCX8A1hUr0U
         w3mTGMixddcrMBAF5RIP3ItHUfomdMATBR7jaBNMOTchPLyA2IViV9Kii2ge0gc+WvxW
         nFJqv60OxudQiqmqZx+3Hvj7cBr4AHxFmV9RIwf6ydbXY4LghKSBOTyk5oHFusXg/yZL
         EFqZmt0dMlETYaCxGV0NjmXr3LRqyJINUvHkZFu/mLUYqRWf902BLEEF+IU2XbecYJL4
         khtbJ4VIoQOZ5pGXiaV2uBenZYXLZSWj7BAM7529GGUbc5aoJ9qUSJFlM64hwJ1+eEVV
         qKXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775283254; x=1775888054;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=enGTakgRN45CpVmSp18YlLl+ReZDJx7Qx15kC5S2n5w=;
        b=nwoMT/d+9fpMXPYhfWmvMLLRD7YHIWhf5QopscVhP8JHYqKig82Hkipc0nmbVbiuIB
         ZAKvPbcPkCR0BFI3Yco6DCoKisaG3+8CZbg6IBEMgs1g8clvrYAT8GgrVyGs0Ec0daV7
         Zy4xxC0ByFvFFDNURIW4zK3phThbHR5fAQN9xACwS8xyrHmbbTOyTBFHRXuKgW+K//AG
         CwZvWf7jeoeAjGHNwFQ1I1kXg16jTzr3StGwNgpw/DBEeA+rvOW1i6HJlkpTHCOcEz/v
         8aYNY9eRo5rO9CqhJN2DSLa1C51fNRJa/y9oNnzIqEA5bqVfNloDl6H4Zy3zYgrJzcid
         B/gA==
X-Gm-Message-State: AOJu0YzNx79JsOVn6COtBI2qcm0MIC3s9tw2rCSHtIKAotvJ+Yt8jXnm
	/szV0GiipciWtSAYo19TQXHEpJxUH2jrERJ/DN9uEJDZgjovrDKGncw9gt+q6w==
X-Gm-Gg: AeBDietTSsLBTQz3CoXN9bO1Fjk/SnTNVkMp492RjxsUKvKYaULel0oL/zSmakK+GMQ
	C+sKPgQKTXJLeOs8iS3U/k/i3jllbtpboGku1NpvBf490c5NOod6uZoJW8EY+Pezuf9N06d0S7Y
	pzXKxXJ/llw4ErfmyfSJNnwNsYtqxH+qZ7/uTEgR9W92eVJoELrut829AehQOjXW41oXzxw+TFj
	DyaeYmikVmbab9hJex+CsweBt8P3SqKAJiewdDTyp4NCgM9DqQIL6e9ee8S4/6bRdeZWhwaCil9
	HDXq41BgVj2xDeV6kSuHJAKYgow7+JHRMRqdCObv1nBuZgZ8tBnvD9jUNQ4ZbehaIZHEll/Jnag
	RGUVvrrxGtVXvywi1FmGhkne7471C73NGXWxabqwGlI8NUD7FiBkubrLzW6y7C2DZTFpGxWZG8+
	IBtYQGNoRSisjMoCVJAXplADmwqXPXJbOi1hcshaN/LzmSy7PSVNBx6Q3ngF25Idg=
X-Received: by 2002:a05:6a20:3c8e:b0:39c:2ca:7431 with SMTP id adf61e73a8af0-39f2ee0da56mr5757355637.28.1775283253919;
        Fri, 03 Apr 2026 23:14:13 -0700 (PDT)
Received: from eric-acer (36-225-116-228.dynamic-ip.hinet.net. [36.225.116.228])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76c6563ce5sm6809085a12.21.2026.04.03.23.14.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 23:14:13 -0700 (PDT)
Date: Sat, 4 Apr 2026 14:14:10 +0800
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: sched-ext@lists.linux.dev, Tejun Heo <tj@kernel.org>, 
	David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, 
	Changwoo Min <changwoo@igalia.com>
Cc: Ching-Chun Huang <jserv@ccns.ncku.edu.tw>, 
	Chia-Ping Tsai <chia7712@gmail.com>
Subject: Re: [PATCH] tools/sched_ext: Fix off-by-one in scx_sdt payload
 zeroing
Message-ID: <dvn6mff3v7ypuf66iagmsuuqdnpi3cxfhnf56bp3s4a54i37sn@up6cwqvg6qov>
References: <20260331091901.219894-1-yphbchou0911@gmail.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260331091901.219894-1-yphbchou0911@gmail.com>

Hi all,

On Tue, Mar 31, 2026 at 05:18:33PM +0800, Cheng-Yang Chou wrote:
> --- a/tools/sched_ext/scx_sdt.bpf.c
> +++ b/tools/sched_ext/scx_sdt.bpf.c
> @@ -317,7 +317,8 @@ int scx_alloc_free_idx(struct scx_allocator *alloc, __u64 idx)
>  		};
>  
>  		/* Zero out one word at a time. */
> -		for (i = zero; i < alloc->pool.elem_size / 8 && can_loop; i++) {
> +		for (i = zero; i < (alloc->pool.elem_size - sizeof(struct sdt_data)) / 8
> +		     && can_loop; i++) {
>  			data->payload[i] = 0;
>  		}

Same fix landed in upstream SCX:
https://github.com/sched-ext/scx/commit/a01197a

Minor, but it does address a real issue. Thanks!

-- 
Thanks,
Cheng-Yang
