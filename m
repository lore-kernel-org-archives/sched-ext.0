Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D353B40149F
	for <sched-ext@lists.linux.dev>; Thu, 11 Jun 2026 13:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781182988; cv=none; b=V7Zu5oet+/lrRbGM3L9wsgxFO3phSXEuhZBYpSNvXNzTTgzIRbpH0B7isLYaNtzDlUoNKTIbcgk6nUR7WTHPudfbTgLRG8tPWrokHC8SInG1oG3kwCUyp3KXfYF4NiK5FjMiMEzc3afLX9Rtfsg61EB3KkCVbtRCsA1g53+qeao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781182988; c=relaxed/simple;
	bh=FJUTQgJGx6IXrIfhQPX2Lp1dXsiUiHyIb3HYZ9zwHrY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iQUr1Je7jNBMfUIDO6lBs3n+zAhCOkc4SpYoyWAV+eMDhyUa0p4qd/1ALo9B7gv0AvJfwjQbYT+8iTPHY8/qDn99VyJF/1ECSKWbpU6soN13pJoDFaFgvRw8e7X3WkuJSnVDvN2gMu+W82meTEBYK7CdrqnmqL8IK0Z8euxlBrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com; spf=none smtp.mailfrom=readmodwrite.com; dkim=pass (2048-bit key) header.d=readmodwrite-com.20251104.gappssmtp.com header.i=@readmodwrite-com.20251104.gappssmtp.com header.b=LBKZf4aO; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=readmodwrite-com.20251104.gappssmtp.com header.i=@readmodwrite-com.20251104.gappssmtp.com header.b="LBKZf4aO"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-68bfcf11050so15012057a12.0
        for <sched-ext@lists.linux.dev>; Thu, 11 Jun 2026 06:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=readmodwrite-com.20251104.gappssmtp.com; s=20251104; t=1781182984; x=1781787784; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wOHuPUCiqJGUeRCVcf0fpUFUwS1pxQLMDdE3+g02YSE=;
        b=LBKZf4aODFrr/RKeFhynVmTNfdADE8VtVShVfpa+pmUAHbj79ThB5e223TltU7lyF6
         cmdiDhhsc/7jGqF50J9v5pnw/hse49UdanGSgciCj9U7623RPC01xWwf4fk2s60cxSrN
         E2NTPs2kcIGkFGL4sJG7XtSJWpOtOTNWFjrMKpuU5mYwzAf/NeKDKVq3/C1v/thrEmjB
         A6vY9kW/qJmD+4wKwHeppM/btqMjKYCbSouqofRTlKvAyeJDl8pNQ1pPG+Vy8yKiYVs/
         GlmNNaFdaZnqPxJBnhNkbzeUbg09Z2Ka+x9wyG5f5R4foCddQEUeY4AZsyIuHISo4lgT
         nsVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781182984; x=1781787784;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wOHuPUCiqJGUeRCVcf0fpUFUwS1pxQLMDdE3+g02YSE=;
        b=G1XRAm+/m//UfyI29O9T/I4TPjbR6+eAxNp8nnEfAg0++WAcsnZtbYzhhybCuk3wfA
         3mA1OHVxctygwTiFLh+9ut8rYwXy3eJnRQ0+HceXiW9IwuM8iVbGa0TZWH7SUwU68GSk
         53/2gFMoMPQZtuCrnc4kHj2Tx8s/m80XxJ++fitvFIpYo8bT+YDfXwRfvbvoI8XWjjEp
         iNjBWoZBvCneRHg03cTrgdxMMLULkE2iUMNN6gxWuPfTLJiaZNBHFymT84NFDQYracS7
         O/LvMY/Y/8U9+0phwK0e0D38nwiKh6blG8R8U9KBR5RytEn2Sjr45c03uUjATAOGpCZ4
         /btQ==
X-Forwarded-Encrypted: i=1; AFNElJ8VeTygS1071d+rt6QKp6H28qud0TxmKQGrDVuIfAHUokCy3p4THEumcxl846m1AhpHRZZjiqwQBxk=@lists.linux.dev
X-Gm-Message-State: AOJu0Yxm3oO/lng0I/TtuCV8YkKZBpw89oHfybqVGoYcEpkksHRSPeXk
	alJXZCykYm55sClAfZY50hZt/w0DzGQwFesyzwhXMrXkKK44gabFXAOysCLr/AqeVKo=
X-Gm-Gg: Acq92OEM3SxFlrHeNKtrAn/GSvWiAEOXG0fPXHAEEZ4jfmF29EZ1ABeYh0FqgevuGCw
	A6r4x0SGTArUWuUlnorHK9rTxRm1FInNDsY0w4tY4bgp+7I9/npvjeSQ5NZ0XdQ9fK9mwAqxlaU
	AWX+g+lV21ISm6AHO/f+zYetUJ8QPr23XBhdsJOGtMJsRq+YYJZs8t/mfJMb3tje+vr1n8wNILu
	D6MGGUw/taMU55G/i5vjsHZjDcdKwwkJ90uOsAQnZ/C5JJPp/Rl4LE+6AJO+UT63ZipgMm2huTH
	blgCrkmBdxMiFaMEQcb8Uy/2w88J3haIntMCdV/wuS+qjAz2KGAbNJ17Sqj4wjtxxhQPCYar7Os
	XrrTIETVSh57yB5awiEIhPQIo5GjWdZOWyzp5h6+XdSrNPm6ELMJLBT0GFRJhX/KWeNaLFTE2wu
	+hZUHhp8N95/DF/+ThJFU=
X-Received: by 2002:a05:6402:2684:b0:68b:489:df9e with SMTP id 4fb4d7f45d1cf-6930e2db4d1mr926189a12.23.1781182983729;
        Thu, 11 Jun 2026 06:03:03 -0700 (PDT)
Received: from localhost ([2a09:bac6:37a8:2696::3d8:8])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-68e65b4d988sm10896100a12.25.2026.06.11.06.02.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 06:03:01 -0700 (PDT)
Date: Thu, 11 Jun 2026 14:02:58 +0100
From: Matt Fleming <matt@readmodwrite.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Tejun Heo <tj@kernel.org>, Andrea Righi <arighi@nvidia.com>, 
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org, kernel-team@cloudflare.com
Subject: Re: sched_ext/lavd hard lockup in old call_rcu_tasks_generic
 needadjust path
Message-ID: <aiqxpzgl2YVVSARw@matt-Precision-5490>
References: <20260609104733.1184001-1-mfleming@cloudflare.com>
 <2179fc11-3bd5-4d2e-9ad8-609e3356ec09@paulmck-laptop>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2179fc11-3bd5-4d2e-9ad8-609e3356ec09@paulmck-laptop>

On Tue, Jun 09, 2026 at 04:23:23AM -0700, Paul E. McKenney wrote:
> 
> Does commenting out the 'call_rcu_tasks_generic+547' printk() avoid the
> issue?  If so, that printk() might be deferred or some such.
> 
> "But if you cannot trust printk(), what *can* you trust?"  ;-)

I tried this and it still crashes so apparently not! I'll keep digging
to find the real cause (it's somewhat cumbersome to reproduce this hard
lockup).
