Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61FEA3CFF4E
	for <sched-ext@lists.linux.dev>; Wed, 11 Mar 2026 11:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773228185; cv=none; b=p0X+9k4MrW9ANB5uSN33EDFpO2u+pOPQ4vAUhMll2zGMG0DBbjxYr/WPqBjn7qL7EzsPYlPQDQR/dtWcvkfMCVTIjeI20yGpduaSByaMni7y6pR56OkGGZRkQk0QuRF7C1EzpbQGfSndq8MuSumnNPvO1BbsJ5weLhtQ3Z/F7Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773228185; c=relaxed/simple;
	bh=xWnMh7mor5Hn0FgtJrPtZ928C3T2hItjd4u8fNxtgBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PMx5mkj144a7d24S5zXp0x8mWx7W0AhZNW2SIMvW5ZPT4Mv4VjXRkZ3lb8UWRQJ3nhlsHMvqD8eTCOzKaT+H1igLyiLxqnZXwmvP/dO+FmV5gRCSwSe+ILs+2BY3iTogehrfrbUcLLBK3+5uQ6w4LH2dv7nmXGfNTe4P0Bcd3a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com; spf=none smtp.mailfrom=readmodwrite.com; dkim=pass (2048-bit key) header.d=readmodwrite-com.20230601.gappssmtp.com header.i=@readmodwrite-com.20230601.gappssmtp.com header.b=i13RNj2U; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=readmodwrite-com.20230601.gappssmtp.com header.i=@readmodwrite-com.20230601.gappssmtp.com header.b="i13RNj2U"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-483487335c2so117545025e9.2
        for <sched-ext@lists.linux.dev>; Wed, 11 Mar 2026 04:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=readmodwrite-com.20230601.gappssmtp.com; s=20230601; t=1773228180; x=1773832980; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TrdzR0jmUoXGyhXDesNFxCwNfrhNUtyGzc/uvdSiKEg=;
        b=i13RNj2UZ8JCevmCAlJG5HObGLea/Dsv7gvJbV5rCbkIyNZIQMfWKPN3MkV4YKoFsY
         6Z7E0ay4qw7oUp3rNvTNTayWo2+K2qcdVWfxorhF0OKBuLEGky8uG2JQXaCb1AUUCp9J
         c3pfvRrKh8uG1qaGVQUb8BIsm6q1kJowu7xG/kxiQ2ARY1DHOvySBJjYKm2Drp9B6kwi
         nCWt4nqrxQMfATunGY7/NemGuCP3pfqEQYNnMaXhpWgH4E7emlh4YZ9yeeJ2+HRGbZm1
         5TlXwsaKuEu+002L9a+iqP+nuewo9Yiu/hjvFOYce4iEdsdfyvgA9synfmMB9dyTRGnh
         +zSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773228180; x=1773832980;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TrdzR0jmUoXGyhXDesNFxCwNfrhNUtyGzc/uvdSiKEg=;
        b=rDyU6aZcCuKETbbc22E4YDvd2PiWXrvy3anksh7sNCNxlRN71tQH3tAdedMZb0p4dl
         oe5A5/zmHP9YO/mKWESBVW+xeLCPG7/US6EsF0JlBMELjg/AfgNGjsM4PbEZSRpeC1N5
         /QlApyFJgaHQ03pGEddDNLKa8eHdEolsGYzhtsIunQhZp3P9OeIKzwcHhegE/2O7sW3Y
         8e1h8TeXS40XIb1J4BMj/rSYKlRP80BEiYQJmorTdrfG+9mt+BWmdXmFxqjf7sn9cu9M
         n7Nr5K6T1RebCMvp5cUJ/7KyCtp9pYj0eYB5VYmk142vL+rHRd5cbMS0M3ZNZW8xvsyU
         m2yA==
X-Forwarded-Encrypted: i=1; AJvYcCXpXhzRu5qSA89NCrrECtDJMIBfIIcer8seMBA/5pNOun/OBBOUuL35rGyw+NddNEwX904+EwD2nls=@lists.linux.dev
X-Gm-Message-State: AOJu0Yzt5I9i3hH0zV6b/39YVMaCbZh9o8qeJ0lsFzeMk7+b5RNezwq5
	nLH+HygUQjKHYWFBKceyFlaYohCgR6oTQeqP73XBwVZRxDUKz4fXQosQ+liJKkw0z7o=
X-Gm-Gg: ATEYQzxo4dxb6cU9af3GEf1RTajxclvWCu8fZc3eU8Q694RVslSeahvgFps9vjXF/eJ
	wNK9G8iQUjcnKZ2tbcIuy2tC6hqAuOuVn205SmXxxWhO+kEA8t9xjcthyLrjxH+BZ0DgoiqsI3g
	rp6ON1Sh3+dLe4vmaR+mTqGM74QRQw7IuEPgAruYYcLuXr/8LXWveBz7Rew1sxTycMkN+n9LtPf
	3/jqMuRAoWiVPDHEIPQkAPravu8l/x6M8lkJoeh9MyOTiZLMQGTb7USxYT/dO52Y31hPrcL+tXl
	D7ZWBQkyM/u+Qzg2i5r0eCTnUhP6Qt9TqsAX+EQfi7foU6g4fGJ9G1zPKgfarRAgzHJPOXznXBA
	WJscs93iDnFPtBTk9AIv9Q2nW0C/VBPGCh+LgBOwY56V/0GkPkTxbpGBua3vk87XuWvWxugOlBs
	jbL0kGDT4=
X-Received: by 2002:a05:600c:8b02:b0:485:3f72:323f with SMTP id 5b1f17b1804b1-4854b0c74e0mr38602585e9.11.1773228180500;
        Wed, 11 Mar 2026 04:23:00 -0700 (PDT)
Received: from localhost ([2a09:bac1:2880:f0::3d8:12])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854b0b95f4sm25660305e9.5.2026.03.11.04.22.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 04:23:00 -0700 (PDT)
Date: Wed, 11 Mar 2026 11:22:59 +0000
From: Matt Fleming <matt@readmodwrite.com>
To: Andrea Righi <arighi@nvidia.com>
Cc: Tejun Heo <tj@kernel.org>, sched-ext@lists.linux.dev, 
	kernel-team@cloudflare.com, void@manifault.com, changwoo@igalia.com, peterz@infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: sched_ext: Partial mode priority and fallthrough to EEVDF
Message-ID: <abFNlwrDdtNjU_yF@matt-Precision-5490>
References: <20260310145213.1060649-1-matt@readmodwrite.com>
 <abBidFKC2Hp6Wca-@slm.duckdns.org>
 <abBm6B7wO0iZKidR@gpd4>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abBm6B7wO0iZKidR@gpd4>

On Tue, Mar 10, 2026 at 07:46:00PM +0100, Andrea Righi wrote:
> 
> I think you can model your scenario using the ext deadline server. For
> instance, if you run:
> 
>  # echo 500000000 | tee /sys/kernel/debug/sched/ext_server/cpu*/runtime
> 
> This would give sched_ext tasks a guaranteed 50% bandwidth on all CPUs,
> (default is 5%), even if there are tasks running at higher sched classes.
> 
> Would this approach work for your needs?

It looks like it would, yes. Thanks! I'll start experimenting and report back.

Are there any plans to backport this to 6.18 LTS?
