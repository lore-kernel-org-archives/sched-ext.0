Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5AF27466A
	for <sched-ext@lists.linux.dev>; Tue, 24 Feb 2026 03:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771902283; cv=none; b=XBQhHu0w6rGFlN8IxgqnqSRCC3n8xkgbUNI7C3k+1trABeqK/4DvgZ8OouSk8e17HRpR3NiGR5R166SIxckCEOI0Du3703W8QW+PpXdN/3nJ0xDfRC3xCltZdtJVoZicjgMEEm3pHN03i9zxtqu/WsKwyzx2Z1OR2UCKppAHoxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771902283; c=relaxed/simple;
	bh=HO7pG62TH/VPUr1tO+Tfd7PNXGTjY3IuYRFKEGj5QlA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tTOAL070lEgKE1idI+3vdNei620+EhjVKRAdo7LnJkEjfdelXbRAZvMmOQoahExkQLElTzA5znLaXMZn9C5sSwvKiHbrAY5cW52MWCL31ZOkv03LBXPtpRC6qogIDhI2J9EJCezBBNyyTjKF3q+PVh2NpUw8F86GGbBGstZ9dlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hrvqFObQ; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hrvqFObQ"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2a9296b3926so34808035ad.1
        for <sched-ext@lists.linux.dev>; Mon, 23 Feb 2026 19:04:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771902282; x=1772507082; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=H4aWTEgFumwMTlM0++KbHcRCNDjJ1iomZeVuCdIJvqI=;
        b=hrvqFObQAIv/I4StYEf/1c39bK8HvWvgY4oRljxChH+B2NxFhFLl1cDwhtcYoJRmPZ
         usLh9IvVzBgLldrbi0YcjdqhM7Ys+w+2QYw0Oo6eAwBRAcB928USQvXYXNZJqK77KrC8
         1HyMc4lv4W1axlBzvqXfSva61D5tDixI0B7BOs8Vpk12I/n+wW79zuyJ5AJ2kilxL8vz
         pd5KOn0B/FjlCe4XqleO08VUoMmXwCdiLEfYxECiCIb4AilJfHZnH9sphYXIYlUju8en
         KRP4h+6REiclJ5pzw6jnu4wwvF4gnXo795UZsircSQR+xSsGqZfYmyQxp7oiJXVu/QBW
         g7rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771902282; x=1772507082;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H4aWTEgFumwMTlM0++KbHcRCNDjJ1iomZeVuCdIJvqI=;
        b=mhnE9hlVGe392KNLHaAyg+cU+HEklUoO3YCf57osKo/oaBUDR0CEbX0O31jBZi1jk2
         drtAfmyi+yHPZQY1tqzWLNfE/5zegUZCIkFy6Ts0+BhYD+qBDl0qTt1ZLr4tImc29li5
         LEE+Wmm+sLuY1Xj2NxcyZ1bi6Jx+wyI8Klm/r320+EH+b4Y4+9Nx/WohANmGtlpsxu+y
         g2f9qoZ9yWNxJ1T/zzUrKAXQLuKuD5UMxIu3e0OYtlqVfYT36EI6J4/GtjS/3UjRWhDi
         iJYrBkxX+kWdRxoGMbOB6yuEulJMFp+eOvyEsN53wd6HpxHGAWlZlHvgtYBaDQsuYbeK
         6EHQ==
X-Gm-Message-State: AOJu0YyK6mKhR0jJjscKskqh5c471Y8A/YOLy78DxNVTrVjrdf+uQZnY
	sIjG8JkO7uMhX6uOAvuU9sn8CJJseIvs0Ab2ErItr4TO/J12O2lqzA8eTfTweQ==
X-Gm-Gg: ATEYQzw8eSXPgwRz/Swx/a/V1syD13YPWALYbcgmeQWOWT7eL+43KXetExCNKLoscQA
	g6f+BRhtnemKS9P4jxAldKRHrSKase15DwzvZwizV5HhKnKQLhGkDqm7VQ1lmn2ROZabR843SLP
	Q7e7aixm7sIfPwJ/evp58Psk6qHy6BE2JYcjXm10Cx7p5VRZIhTCagOEHLz+P/Pvm0vwtOW8bdk
	5g9z2kKrUFNQYCMue+QelZI/XKWDPE89q8nwWZKHrl4Tc1C6aNWIZrqqlg8BEbQMT4nHLtpSIlK
	czU02CvTF8/VQuK3iMXukNnQKHFuMiT9TnJcDjXuWbhSg1KmwfHORngL+R+63xEX1ZaV6hj8NrG
	Nw31/7EFfZK0C2eSz2Y0EM3293VGY06+KNv8bLatEr3HIj9YrSxIXQl6LXEeYL86EX7G09Sexzl
	7gTH7yZroBXMD1XwwlI5x/pnnuPPK21wCiv2PYSLWyaTlc1Ts5hgs0PSSi+U4s
X-Received: by 2002:a17:902:e787:b0:2aa:cfee:a47c with SMTP id d9443c01a7336-2ad7456550emr92122265ad.52.1771902281635;
        Mon, 23 Feb 2026 19:04:41 -0800 (PST)
Received: from eric-acer (36-225-69-192.dynamic-ip.hinet.net. [36.225.69.192])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c70b7243505sm9119117a12.19.2026.02.23.19.04.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 19:04:41 -0800 (PST)
Date: Tue, 24 Feb 2026 11:04:38 +0800
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: sched-ext@lists.linux.dev
Cc: tj@kernel.org, void@manifault.com, arighi@nvidia.com,
	changwoo@igalia.com, jserv@ccns.ncku.edu.tw
Subject: Re: [PATCH v2 0/2] tools/sched_ext: Sync configuration with upstream
Message-ID: <aZ0VRpQ5KnpXjNcd@eric-acer>
References: <20260217072600.953197-1-yphbchou0911@gmail.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260217072600.953197-1-yphbchou0911@gmail.com>

On Tue, Feb 17, 2026 at 03:25:58PM +0800, Cheng-Yang Chou wrote:
> This series synchronizes the sched-ext tool's Kconfig and README.md
> with the upstream scx repository.
> 
> Changes in v2:
> - Rebase v1 to fix application failure.
> - Remove duplicate Kconfig entries and non-user-selectable options.
> - Refactor Kconfig comments for a more professional tone.
> - Link to v1: https://lore.kernel.org/all/20260216110014.771335-1-yphbchou0911@gmail.com/
> 
> Thanks,
> -chengyang
> 
> ---
> 
> Cheng-Yang Chou (2):
>   tools/sched_ext: Sync README.md Kconfig with upstream scx
>   tools/sched_ext: Add Kconfig to sync with upstream
> 
>  tools/sched_ext/Kconfig   | 61 +++++++++++++++++++++++++++++++++++++++
>  tools/sched_ext/README.md |  6 ----
>  2 files changed, 61 insertions(+), 6 deletions(-)
>  create mode 100644 tools/sched_ext/Kconfig
> 
> -- 
> 2.48.1
>

Gentle, ping!

Thanks,
cheng-yang
