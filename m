Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CCDD40DFB4
	for <sched-ext@lists.linux.dev>; Mon, 30 Mar 2026 04:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774845621; cv=none; b=YcoT0z7z2YHLsUb+xbG1c+TwKRzT3A7WEbuJpqhwALLdwRoavyDf/c396XcwV9jKQMELqYcvsc2BcqXsp/ygn3XkarGmdavCTz9Di8z9q4Oo53O5HLhzmO7keZYx64xIaSpEPLJ+O3t4QVXc2ROY8Q0yePWTIRlT2HUSGmo0wqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774845621; c=relaxed/simple;
	bh=rWOF3V2xnaI3zH932M7v2v2L8KsWHxiYAXkOXzxyF8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bIYsSWzKuxu02Y8EQY+2P8F7VzUGviv2uf3Ees6+Hr3ncU+h+C3BuH5YytYKOQo5Pd4L/aOIJuIttlBgITWWNFdqalkkEJzz+jb9xriJSsMZvevfO+lZLLHCD0wYqAy4YuRjtLztCSsm+rMJ1ps5KM6Kf8NxeFKXgZzzZxzOtyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VavMANlO; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VavMANlO"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-82a3d3235c9so3450108b3a.2
        for <sched-ext@lists.linux.dev>; Sun, 29 Mar 2026 21:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774845620; x=1775450420; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ruDoiQUAfR36vOonPGaMaqIHkaDbg9MLjJ0P1HEnzZU=;
        b=VavMANlOSj6mYOyvTEGk4lhV1rSkflekGd359qN+YqmuOloWXn7h6hbyExdHv3BUF8
         88zEksGvSk9wJzvyOPMSh34PQpB8nJOCx5wElAMHu7Ur83b8s0bKsqeLIovKoTJdfISa
         vSdiAWtBCWtXlAEnbB9w0q9ZB2ds876fPnUwmoGmldnKUwCaJI8W3ZVCbykbJGSSmofa
         2WjJ5BOggmGA1X3nmuTfpERseyPG22IZx7Rpct78xliH++DLAkbDcvy73jnvL9djIFJj
         rDvHb7jNnUCLI5JKi0cOwU08hRtvTk+0rhCDCuE5JEq8tNGqiiSxeKqeC6k30h8uK8GC
         7FKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774845620; x=1775450420;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ruDoiQUAfR36vOonPGaMaqIHkaDbg9MLjJ0P1HEnzZU=;
        b=OfgtFI+wuFkcCiNNzo+9Q1+24VO5WscqDNU+vS8njn9GpzDIA+vthIGokDgp2r3GVi
         HFmuaeWCTesUY1RQJGi/dxPcm9EjruvxPS0GVDsilIYq7OAV+80Ctzy/Gh0MGgxgcHh7
         GcKBPrjwSYC/izgCvvTPquwHX8jZV3CrTcOrkfwYRbS5CQRmxjfVZTaZVtOGxw9QnZA8
         WnARfLbWObzcxjbvZH6UF6ffPtTlvto5Vi1SKf5f29Xciqf9dTufOw2eunF5invDDMB/
         SrqQKyf8UJWiO6EUH7OHDQniJcP69wvB+JPh9a5uCia1CLRVFTEWvjBwLCCLDCKTIZwQ
         A4dw==
X-Forwarded-Encrypted: i=1; AJvYcCVynj3Hz3yzdrHA4a0xfw1QGqjDtLaxpDeo42yELo9QsFSphHcarM0L894qIs0KMBZ1u6CONnjwEu0=@lists.linux.dev
X-Gm-Message-State: AOJu0YxUPOfat02hJolT4zyBFVJgg+SvUQ/9f0DYj2GcUoZokHgrxxJi
	uotafL+L/eAKl4mUkUb0e4CaLJQufVu6FdY5zIp+AKLqrat1LYKGytEx
X-Gm-Gg: ATEYQzywTKBXdaP47q4vmqdGOGPzW9p3jLTgRdcoteGrVdPyM70EHmU6178g9Asml4Y
	5OwyYwYlag7Gs4LtOo6lgxdGZJaftZvgbVBRTeLCUXV42JpeC1i+QJpmaC/pLJIp8+sQ0+/yIRZ
	9toqKr8i+NKAvCybtUZEV5JVicJ/AoN6UBybPrX4a15sv/Jr/tRVQzqnwUFsv6ExapLfrZeclYp
	QN4QEaXgd6Qis7Dz6XHFS5Uf+Kc8yfNmEkKq58W/JzHAt+jNk0w5LbHl+33oJQHXb8QOdeRFeSJ
	fDEuUG/4GIIKtrH1BKLsdoOWjgLiA9dCzSZeFBv2ioG8ykf3q19HyxXFE4nq8mZOk1Frt43DqZV
	oLbT7fvZP9gTXGbpmDliRyfTTZylXZHJDg0gstAnt1DA/vfaCIOLH12tvwe/MBGIGAsqw6pHF/i
	+QBR1Et5qntI5pGKlNIo8VQEdDWfABl6KGfmQY1hILfFOZ+HPrKfRgUiKh/g==
X-Received: by 2002:a05:6a00:27a0:b0:81e:12f1:d8a with SMTP id d2e1a72fcca58-82c95ebecabmr10833957b3a.34.1774845619774;
        Sun, 29 Mar 2026 21:40:19 -0700 (PDT)
Received: from eric-acer (36-225-73-11.dynamic-ip.hinet.net. [36.225.73.11])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82ca862dee1sm6124475b3a.61.2026.03.29.21.40.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 21:40:19 -0700 (PDT)
Date: Mon, 30 Mar 2026 12:40:15 +0800
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: Andrea Righi <arighi@nvidia.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, 
	Changwoo Min <changwoo@igalia.com>, Christian Loehle <christian.loehle@arm.com>, 
	Emil Tsalapatis <emil@etsalapatis.com>, sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Ching-Chun Huang <jserv@ccns.ncku.edu.tw>, Chia-Ping Tsai <chia7712@gmail.com>
Subject: Re: [PATCH 2/2] selftests/sched_ext: Add cyclic SCX_KICK_WAIT stress
 test
Message-ID: <7orrkdssfovhjymosuumtd4bcaw5igsmfkn6s3y3qjlsp3tbzo@pingldf3qnta>
References: <20260329001856.835643-1-tj@kernel.org>
 <20260329001856.835643-3-tj@kernel.org>
 <r36q4trzw267surx5xbod3ilm4wgmmyurqk6kres6gmtj7qbfl@lyasdc3a2zlk>
 <aclKrNMA4CG7K5K9@gpd4>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aclKrNMA4CG7K5K9@gpd4>

Hi Andrea,

On Sun, Mar 29, 2026 at 05:52:12PM +0200, Andrea Righi wrote:
> Hi Cheng-Yang,
> 
> On Sun, Mar 29, 2026 at 05:06:20PM +0800, Cheng-Yang Chou wrote:
> > Hi Tejun,
> > 
> > On Sat, Mar 28, 2026 at 02:18:56PM -1000, Tejun Heo wrote:
> > > Add a test that creates a 3-CPU kick_wait cycle (A->B->C->A). A BPF
> > > scheduler kicks the next CPU in the ring with SCX_KICK_WAIT on every
> > > enqueue while userspace workers generate continuous scheduling churn via
> > > sched_yield(). Without the preceding fix, this hangs the machine within seconds.
> > 
> > I think it would be better to skip this test on older, unpatched kernels.
> > Sometimes I use my local kernel for testing before the stable patches are
> > fully integrated, so skipping the test would be a safer approach.
> > 
> > Otherwise, this test can stall the machine and make it impossible to
> > exit the test runner.
> 
> Actually, I disagree. The whole point of the kselftests is to expose kernel
> issues, including bugs in older kernels that may need fixes. So, I think we
> shouldn't skip the test.

I see your point. While the system stall is a bit painful during local 
machine testing on unpatched kernels, I agree that kselftests should 
remain an effective gatekeeper for kernel issues.

Or maybe return SCX_TEST_FAIL? 

Since without this patch, this test won't pass anyway. Perhaps failing
more gracefully is a better middle ground than stalling the entire machine.

-- 
Thanks,
Cheng-Yang
