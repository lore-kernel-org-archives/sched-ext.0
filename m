Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E5F4374E5B
	for <sched-ext@lists.linux.dev>; Wed, 18 Mar 2026 08:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773821770; cv=none; b=cDGXISrQWjJOSqyvamN7uoGTk/lYDpWa6Io7fsMtKzCFsfa4s/QCwRXJi+Wfhxc/w5U3iDDQMMoN9SbGaY8x8WFklGmLz/m9ph7hIgtSfeybrL0M7wY+6Ie55YQyVdDjzTeCtGb2a0y1NP/xxgizRMLACHUDHXBipuFRRq4MyNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773821770; c=relaxed/simple;
	bh=+sWnZTZI7tRDagieoGZ912iRmUTtk4dAhIpGp/Vjdr0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NiXFHCOMfQ/q197P2VCo82+YY0ej6eMhs6GFvcxn7xLgGAeDXPRzJClfc6744L2jXW5yeb99K8sulFipcL7uAqR+MzeA0IP/AylWjBt8mI858wXi315LWgsXvDRMpwZK11tHVIZWpdfbYc0GnNDjjzgoL8+041mc65Lt+F5E0v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TYCYRgIB; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TYCYRgIB"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-827270d50d4so6140874b3a.3
        for <sched-ext@lists.linux.dev>; Wed, 18 Mar 2026 01:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773821769; x=1774426569; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1TyRCY1PjbaXhBQLCPF3GQ7ptO1QobaJ5bFC82lbNs0=;
        b=TYCYRgIB/v+C8muqL7yI3TKSmN+VSF+nV2B/nD7ey0CXH9v0+pKwZI+izHD2Z9ugPW
         lLpwQ+sl0cdlI0Kt7iAruZD8/PuUWUiQRX8bz1r4QyeGR+fTr2GmW0oaLqSBs7m+sZGz
         m5Vl/ITfqNNWvGSDuuNk7Oep4aHhAr61fmL9WTUiTD9jVZ3nIZCXfSuIDSMbNdkyxrT+
         zIiJYIKGbI6Be0IgQ4mJAJ4yBWnQsA25HlXSeA0uZAChUgzOk3fqa5hIe6EyWqfev4sS
         CDd0KcPVxQeiFlAkUdtyjiWhaCtRFACB+QmOxsWFhk8nmQFbgUTRRF/5ffuN2/6GW3hm
         C7mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773821769; x=1774426569;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1TyRCY1PjbaXhBQLCPF3GQ7ptO1QobaJ5bFC82lbNs0=;
        b=eRKcRIVAPMHWiARLURSjEBn+Taz+WQ9Je0TaD7RZcnm2RRCHrPr6fSIubZIIcKzSwt
         zLMN9xLWo39gZGm5Q8eBFE6DescNH7IC9eEX12pHo5SlvlZJ2/03BZO/7UxsvDsfUyWY
         A+vqG5ZgDmfMbp4GoBDUg9wncCPsEcb0cZll4V7/we7yPPo/kyTPlOLHEy7H8BscPvu3
         LFXQkUj+P3+XP9gUm3z/+1LXNEhOAISmbrWLrMJKVqmRJ7xy7pHhf3cfTQ4wJr/HzVF6
         6fOxyOwe52bIVz4SiPGyt0iN6ZDWeC2UOsLFiT9t6rK1BhW16Jnrr6NKzyCVAWObXolV
         xbtw==
X-Forwarded-Encrypted: i=1; AJvYcCU2z5SjY7PtXU9l9hWcth7S8d7wvYwnJtmtaJKoYbfa7Y/5AzJUwxfnovo/4MQhhLrAzzu8VlBcR8E=@lists.linux.dev
X-Gm-Message-State: AOJu0YwFvBLlJpT6jrK/PfuKTovzqotZJ1batIPixoaIVgLZBZOl+eN0
	oHNmo8MOu5KVTfqyoH02poEjjmofZ0+pJ8sa8jwBgdsjY71dy8YdgiiY
X-Gm-Gg: ATEYQzy7F5CCqH/8ygwfdvRrqDUaPDiK1O//rLr9D43L0J3/Af/GKFE5Kaqy+jQd30S
	qQCC5dIjfXQueMklfYVRZp/QJRYoWQFuB4ahI5SLb5ME2MuxmkRB0hhhkPHKq1GTA7PQH9mMLzv
	+x+ScNB3HILqDMt1lksWR/OPaVBD937sDoWXnUTeeRBKPMpM2rpVG9iO4DzBUMf7te1lZxeapMD
	DnEIlAfYOVC6xrteWoni2ntCaBTS5CglpCt2z5Xo6hZRwtMMF7B9XIUmF2li+h4cgW4AfRGQgSR
	d1ncA7mL7bgIQT92PYx5DEPZ6leefem0hsaQqdJHKKNobbST1zxAAJFVZ3q4qsWXmgsXpaRDHQp
	mkGDpVo7U60NsHXQ+AXm7PWovT85j0Hk9Ygy2lUruO4eMEfClYthbsVJow7+aYeXOzzmapZUthQ
	mn2r+LTZQrMfEDShFtJ6o=
X-Received: by 2002:a05:6a00:ab85:b0:827:2c46:bab5 with SMTP id d2e1a72fcca58-82a6accbdb2mr2518596b3a.9.1773821768522;
        Wed, 18 Mar 2026 01:16:08 -0700 (PDT)
Received: from eric-hp ([49.216.25.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a6bddcd43sm1571348b3a.50.2026.03.18.01.16.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 01:16:08 -0700 (PDT)
Date: Wed, 18 Mar 2026 16:16:03 +0800
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: Ke Zhao <ke.zhao.kernel@gmail.com>
Cc: tj@kernel.org, void@manifault.com, arighi@nvidia.com, 
	changwoo@igalia.com, sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, Ching-Chun Huang <jserv@ccns.ncku.edu.tw>, 
	Chia-Ping Tsai <chia7712@gmail.com>
Subject: Re: [PATCH v2] tools/sched_ext: Update stale scx_ops_error comment
 in fcg_cgroup_move
Message-ID: <u72uqrur3f2jcskh3hjezx5wzj3nkhrdmniv3yba424oozb7oj@tx2b7vawmqmv>
References: <20260318061457.49988-1-ke.zhao.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260318061457.49988-1-ke.zhao.kernel@gmail.com>

Hi Ke,

On Wed, Mar 18, 2026 at 02:14:57PM +0800, Ke Zhao wrote:
> The function scx_ops_error() was droped, but the

Nit:
- s/droped/dropped/
- Use scx_ops_error() and fcg_cgroup_move() (with parentheses) in the
  subject to denote functions.

-- 
Thanks,
Cheng-Yang
