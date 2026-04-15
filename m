Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598EB314A60
	for <sched-ext@lists.linux.dev>; Wed, 15 Apr 2026 10:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776247654; cv=none; b=nTZGoNh1m11bPEqKbHyJyn1vQ6MwcpDHijKHq0jKftMLdUc8tsyOI7MDOO225raJs/hJZX4ZAe/9roDZhR3FHSBgTLYDy2SqYHFayD9PDaWJziZYWcutVHq2QGPYjysdAPoZcEv8eocUfZxxMq1bWWxI1beWm/9ijRvWGXNSEe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776247654; c=relaxed/simple;
	bh=PTPKWg5OGGslFidy888MlPEtgzmNqroe/Ept7CFFB8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D5LtXiTLiD9KknArW/Mh8NJSNLCQGg5syETor/Z33HDKvwv48kFQnaNwW7knXj5B9+UA5nYr0eumtGrttGiUkhhJLU7BPurMJdTrrJqnUFkgmz5hd0vN1+ArlFteVtRC2JA5L2r/bf92KUUMDSmoYJtA95wGPCLhxXwsZ1pgiRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mGMhv65W; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mGMhv65W"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2b24fede2acso39118825ad.3
        for <sched-ext@lists.linux.dev>; Wed, 15 Apr 2026 03:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776247653; x=1776852453; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Wds+wagIg7TBxu+Y9e9BbJSYDgXYELkc+t6MjLDgLJM=;
        b=mGMhv65WwRgP9ynitKjrLMtlCs0L3gc9+/hI4HR1qkfTOADH/ZprCJGjlYFWiZCC0I
         LkJG4GNQTV3qc0pfunjJtWxit4mOyMCig9RiLXoe6qA2Sj2LoXshYrz9meUAcXPtEgmX
         fNkRxywVDZhMFL7Z7e7MGk6e4fQ1rJvz+Z2MiuUsLEBAiLG+rrAuuM9kqew+2POf8Us9
         psBx+3uDNLKcuvF+V7HVb4ZnR/9Samrt78qwhLyUxblLMkKcYsekTOhpng/qKKFi0tgm
         vLRVwlA54QV3kO6XdD31ask8VG/6xGBljG/4YYSuwuvrq76HsmbW7fJMqJCF/gJmxTh4
         AxSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776247653; x=1776852453;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wds+wagIg7TBxu+Y9e9BbJSYDgXYELkc+t6MjLDgLJM=;
        b=LM9jSQaobOBIcv8s3nlKfHT9N8TRCgLJdNV5/vRoi18xh65Si83xSbdDKkezcIxlSZ
         aeR2Z1cAaPZWpTm6dCH22I4G6jStpFQoZ1izILgAjf4kJYWciVcZ4zn9RzE9+2b4pCTA
         KnaWB+0FYtgOGUvkVtaVXmxuOK+8KwgdNA+DidejWY94+wnY9Q7P50r90rWb0/pNsPZ4
         wlORIeB/Gp13/GdogpT5+WzqJvVDPqkW4wHfFtWIF+wTbajkbjVNJGhMSDIsQFb9AhPE
         5PvNdC+jhfzmfR0b01zBbNXMbudFLe0Bo4Hz+0t5gD6/ZlkGlBSqjbTytB0L+Yd1gUd/
         /c1w==
X-Forwarded-Encrypted: i=1; AFNElJ/BcX2cLUaFgNgDWf9n1GkZntQOvwwW+o7w8sE80bCpOIbRhzOcgElo+Y+KDvWO909Eu+J96FbD6nQ=@lists.linux.dev
X-Gm-Message-State: AOJu0YwhCBJteA/Pmv8ESTLeKVtTOVf4pHS0iZsLcslO1zFJTC0oqMLZ
	nNe7wOLyT+mxDTs5+IfCKb+9Amo+qsx0D4epm7VDWvgfu5+y5LMZBtoN
X-Gm-Gg: AeBDies9AeZlHFaYCFXd19/5gxVYlxJ4Cy9txCmXV0+c4JmDa/saFzHczqn7WQBfCUf
	x7OM9BkdTFewV0pZ0Spb8/KFiOxKtOlfCWobpDEwki2nt+Ez4I8dKRdZ0YCX73Mh6Q6FjSsaVtl
	nd57nGn60iWtpCCTB8FsvQD0Dc/Hpudoemaqu21Wr6PTFe9k2lcJpy6E0bcLU/2KwPDRoRY8o/d
	h+OyAKhQ15bWYvoyUdJLfG4Clw1i34mUg3Z4oZMwsG3ns23wHorbcY1XMRvYKCWoRzpoHRReSDu
	a5Sadm3EbfT9CcY4/mGC5MuZFcg+hH2LlaS2lQU6jVxR3+EXjFKMoM0srE0YGI9Xll+4RwHQKqc
	O/Cx7CDPY5AgPxLV2Y8fABn/pL1AunmEuBIH8bZvXVytLKlI1dEYKe7r6elNq2qjD2sIabJ60Wd
	rQ+0zYjeTteMx/ES1raMc/8O5koHVUwFuC+D0LmND8g40SS+7SesML7H5JKffyZ84CYjlTZ5nPZ
	w==
X-Received: by 2002:a17:903:27cb:b0:2b2:4cd2:e16c with SMTP id d9443c01a7336-2b2d5a346bbmr135540395ad.20.1776247652533;
        Wed, 15 Apr 2026 03:07:32 -0700 (PDT)
Received: from eric-acer (36-225-123-187.dynamic-ip.hinet.net. [36.225.123.187])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b47826e11fsm22527455ad.44.2026.04.15.03.07.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 03:07:32 -0700 (PDT)
Date: Wed, 15 Apr 2026 18:07:28 +0800
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: Kuba Piecuch <jpiecuch@google.com>
Cc: Tejun Heo <tj@kernel.org>, sched-ext@lists.linux.dev, 
	David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, 
	Changwoo Min <changwoo@igalia.com>, Ching-Chun Huang <jserv@ccns.ncku.edu.tw>, 
	Chia-Ping Tsai <chia7712@gmail.com>
Subject: Re: [PATCH] tools/sched_ext: Handle pinned tasks in scx_central
Message-ID: <h3xt5fmscgcryankdvhnxu6rcr2eucmll76z4bqysu3lkgq7b7@uyy4gr66uili>
References: <20260413110453.357198-1-yphbchou0911@gmail.com>
 <DHS4U9BLRCPG.1S9E4BT1UIHQT@google.com>
 <s3khi4ec55rog6tgbgxip5skqjdhimcemhwzf3h7pbbvxslnu7@5r4v7jbv4w7z>
 <ad53CFXVxTha3EQu@slm.duckdns.org>
 <3cpy5o3wdfqrmk7kuvwlvibnkesvzprjru5urhyvf66qytnjeu@jibpzykbt65k>
 <DHTN2MJP9V4Z.221YVTILI5XR6@google.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DHTN2MJP9V4Z.221YVTILI5XR6@google.com>

Hi Kuba,

On Wed, Apr 15, 2026 at 09:59:33AM +0000, Kuba Piecuch wrote:
> Looks good to me!
> 
> Minor email-related comment: I would prefer if patch revisions (v2, v3, ...)
> were sent in separate emails with their own subject line, otherwise it may look
> like I'm reviewing the v1, if you look solely at the subject line.
> 
> To be clear, the following tag applies to v3.
> 
> Reviewed-by: Kuba Piecuch <jpiecuch@google.com>
> 

Ahh, thanks for the review and reminder!
I was just being lazy because I thought keeping it in a single thread
would mean I wouldn't have to add links to the changelog (but yes, I
should add them anyway). 

I'll send future revisions in separate threads. Thanks!

-- 
Thanks,
Cheng-Yang
