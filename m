Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C0E191F98
	for <sched-ext@lists.linux.dev>; Sun,  8 Mar 2026 14:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772980894; cv=none; b=DfHxD0YiYXXZ0C1WD3jfmOy0g+nfIxPsgCTewos8QB5X5482GC7d0ALO8pBRMjeG3/rRcQHbUvdc3vwp3GsjE6XNE+MNj/kjhxKY/vmAogrEUhWfeaRHBqT4GK4xYPQvyvh5uIodHy7Ltw7s0HcQQ+uAOI3agLj/3UR/Ouizo/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772980894; c=relaxed/simple;
	bh=vOQMQjoX5jnmUvHKBMVkWMnTG+mvKRs4bgD3cVLiZ5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dzRroeoqjqiHR6vUFp69HKfUw4JqKEUhvKkR9fPdlXiAypPIAJufzJiHTQt42TEQQOm0ern2mUTD/1bLr+iGLFlU1osFzFO4e2awx1gUYCAw1MddL5SYcA5+Q8/IriNN+cE1ub/SywKhBRnm0x1dFcgZDNtHxf/YvH5sUAYd6Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PeVDA2XS; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PeVDA2XS"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3598df39444so4563536a91.2
        for <sched-ext@lists.linux.dev>; Sun, 08 Mar 2026 07:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772980893; x=1773585693; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LQ+xQ6qglow+nD9FQ1/SeOW8S1H9qWAXHKlyYhBT1DA=;
        b=PeVDA2XSKSJLxh0zORdAcOkGNUQxRRJjlDQGT5Ly3WnkfT25w/brAVR37bSeoM8ie/
         gQeAnpaj9UVIfgsJTJ3sDMAwx+WrllBaIgCoEq7Vo+WGKb+JEM336AEriHpLtjmxDCZk
         XLr4onEAZDnM+vyY02yljtvsxo6O9efWj1u0jhpyBt7XM9ykdivQHv7MvZK8/2EIAytP
         Po/xzBgAJvZuZCuJFibWPFYdvf4gJ0RiUG2HoJVPgzD+6ggi6VWdC0slj2p+7C2LXFBy
         oTrXQ70fc8hxrKpmazrx7Cg6C/JdTOhnRe1Mi+203v9gs6HVhGjBOUm9VqzG0tyeTBh9
         u0YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772980893; x=1773585693;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LQ+xQ6qglow+nD9FQ1/SeOW8S1H9qWAXHKlyYhBT1DA=;
        b=DVQHRmINWRPvNtcDSTb6fTUPSG2roLpYRF18W2PpMzJIi8ACBEKYY3LkpC07BgCCIQ
         GME7xdTUZ55Xn4zQacKCi0H6UQYk2gIJg+sHVMS7uv0K++FBda6zWrMeVU0R1E8qC2E7
         SaKTENRpKStzpIldPFf5ZoIGqfpfHXfjW04f+dI9n1cEo1rTO1p01iaSSPvIOfCqzyOP
         YrDsCBjZzh3mZNp1kX6w3Ju4LwnTT6YFWpgTdUKL39446uHPaO3NVB0l3KOERqbvBlUh
         6H6MoeF+1sOak2MUfYUnntF8yKe8sMohW8ru6LVeypF+x9tAETBudsrOhq0aljDSKqRy
         yiww==
X-Gm-Message-State: AOJu0YxHZKsqCsHuFSn+GafSejG1fbqfvAgVppfiu8FslXv0ksmpSyMb
	cYMPpn/QrZDbJd6/9NMQEPnc2h9yclLBBY0nbObNHlVZh3iNwcUrWUfH8/zWHQ==
X-Gm-Gg: ATEYQzx4kOjLc4byIn+EcAJcF0D3TuIxkYyQFf+9IAr+yNZh7ovkKbyKm5LrnYp51KM
	uhT7t0raFrmF98ROqfrxYPtgAAMzGeOkTnn60OilNQ+mNR8wnV6W9vh6V0U+6PhXaGS2uOkwy53
	dFuSf948wMXT0exaUsqekkFPe1cuHmDkxX9PleqDxDBkrD8dcg4NIr7/Sw5KQUb/DDRaNUPsbxy
	qUgPvXNyQaLWzqIA0I2Qs4NsEyGYux6EsqPW65FUil6Uo3PxokZxF2M2G8sr8GgPhI5lnqXUBYn
	LBjfki1YAxstXIweMh22Txc8RM357P4T17h0iiqCOn/hj0LIlrgdAYR+pwq3bt9FfpxmPds7ptQ
	9Bn5dnGhTY71qWdWQ1y2OPEn6SWXmWqlyNjaz5yKHgM+gO1pg44UoFbAmOjh30hTSMQYKu0T4qC
	YAhtWHAQlOA3D6jXtzwF+uNwDaT6nn7S1AbCP9ng/68GpJt5ux+R5kSMPzDBxzQS9xvctA6Ig=
X-Received: by 2002:a17:90b:38c4:b0:32e:528c:60ee with SMTP id 98e67ed59e1d1-359be31746amr8045806a91.24.1772980892555;
        Sun, 08 Mar 2026 07:41:32 -0700 (PDT)
Received: from eric-acer (36-225-99-218.dynamic-ip.hinet.net. [36.225.99.218])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c739e184f92sm7179494a12.28.2026.03.08.07.41.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Mar 2026 07:41:32 -0700 (PDT)
Date: Sun, 8 Mar 2026 22:41:28 +0800
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: Andrea Righi <arighi@nvidia.com>
Cc: sched-ext@lists.linux.dev, tj@kernel.org, void@manifault.com,
	changwoo@igalia.com, jserv@ccns.ncku.edu.tw
Subject: Re: [PATCH] tools/sched_ext: Fix get_prandom_u64() prototype
Message-ID: <aa2KmIoXTq3PsPsJ@eric-acer>
References: <20260308130638.719915-1-yphbchou0911@gmail.com>
 <aa2BV-YMfe_NHFwV@gpd4>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa2BV-YMfe_NHFwV@gpd4>

On Sun, Mar 08, 2026 at 03:01:59PM +0100, Andrea Righi wrote:
> Hi,
> 
> On Sun, Mar 08, 2026 at 09:06:38PM +0800, Cheng-Yang Chou wrote:
> > In C99 (Sec 6.7.5.3), an empty parameter list in a declaration leaves
> > the parameter types unspecified (K&R style), not explicitly zero.
> > Consequently, the compiler would silently accept arbitrary arguments
> > passed to the function.
> > 
> > Declare the function with (void) to form a proper prototype asserting
> > it takes no arguments.
> > 
> > Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
> 
> I understand the motivation, but changes like this don't fix real issues or
> provide any measurable benefit. Patches consume maintainer and reviewer
> bandwidth, so it's usually best to focus on changes that fix real bugs or
> provide clear improvements.
> 
> If you encounter a real issue or can show a measurable improvement (with
> traces or numbers), patches addressing that would be much more useful.
> 
> Thanks,
> -Andrea

Understood.
Again, thanks for the explaination.

-- 
Thanks,
Cheng-Yang
