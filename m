Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6A6237180
	for <sched-ext@lists.linux.dev>; Tue, 30 Jun 2026 14:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782830121; cv=none; b=gr/v/ITeJ2J3MoNMp3fOs3cHMSqkHPaLgUeRqHmIAlyjXQkufD/C+dEK8otQGRD16gWA+dzhlF0XAMwaBfZU+xESLUWEESPHI+kUibp4kdBkIEhghnHRcOnx/HTTZLQ+d1um0FjFvzxnx//s1BfytmRFp9l6cqJRSptljNrkkcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782830121; c=relaxed/simple;
	bh=IRkz+Gw1UmObcFkRm1n/rf9c0tmqtSNQj0SemANY2GM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y8TGNFXBlfMWcmxkimma/7amSAXc1P/xwq2ACkBongYP1PTrGa8u9PCrZz407FCva784PgT1lW0AJRAu5F8uHWZEKnw4cS+CTChCx0movVHTOLZ+GcX8DczGnKtux9uM2WUPwM38wUT1CjrSYLgtb/yDQZb7ShE2t2IlP9X3zIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cGUdo8np; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cGUdo8np"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-37d55e8d3e3so428786a91.0
        for <sched-ext@lists.linux.dev>; Tue, 30 Jun 2026 07:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782830119; x=1783434919; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZkQVJRDOOTVYEroIqfYAuIyib5tIWFSb+9cWxfqq3U0=;
        b=cGUdo8npgplotnMKK3DrSnfVbJk8XlCx+qsEYfGQXSQZUftKEcCmJ+TFDzl4ScbLaw
         bFJyupmrLpxoPuXbFsfykCVGGBiIutLa6aYl5D5ANX/axiMUBfohKnDvpdRvItU8sOAK
         YT/HrMuQ3aapjDT1Tg8dmdOwQp4GNjsHBOtibyV9y0ICJl2oyywjpFieBnkRtno7nrdS
         umSIwmX0lHs6z4f30FuCoRJNoq0Bp8Rx5WD076om+CCpvUlGPCKmg4/oUKGH81eu9Ce6
         u38z7ZkvdBDYhgSdZNfy/m0ilYwtb3YrfLt4ZfcRt5NjYmiTZcCbqDb2KbpmvnGpWmM5
         waLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782830119; x=1783434919;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZkQVJRDOOTVYEroIqfYAuIyib5tIWFSb+9cWxfqq3U0=;
        b=kb0hGFV6aJIVqThG5NvFnsO05OuLyWgqln6HilIKVf1RSjFKDtlDfHhLOZdgfR3ZNC
         9W8N0J8w7XpI2CGWAOojjAuIuQdNPTtW6FKOhSZunk64r3F5WglrFp863f8cSjqzk6IT
         sE3yX+tDUg0VRy4DGh9U/zRQrSL4aS6ZTYECCU8tsLw4K1oUZ3RFKV8nTDb6AW209gLb
         HXvaR8rT/L+Lt2kzmdutgxyViddleLKoxbaNFAJud9qnDXIlT7c2j42pksvIFtizz5eG
         +Iu4PPe8OV4kgyf1hsCqhxbB2bWYKOAK0+G5u8zR7IModvgnWdHH3mdxc8l/w42R3d5C
         XvlQ==
X-Gm-Message-State: AOJu0YzKdaomHMO+mfBH44NS8EjWQDpWi3R2ge72DBQI/2r/MbI1NOm+
	6MGSoibNHJ9vbpMvBOKZVdwOQkIZ87rUbvaodAcULyhOOdtrP9jXpDDI9CaAeA==
X-Gm-Gg: AfdE7cmYCliNdGUmvV2kxS0JDirvUXR+qV/gPgn7//Xq/Q1TS+47cCCeKtaj5Eb/I7B
	tMjLUIhV6cu1nVwFdsolg2wtLV76g5egaqcHJCrGJYWqkrwncbxXeEccUZVPyOSiQtvVHNP0gtF
	zCmyPoK50sKH+4BYA0F9W6BO0y5yhQeVx4vobMUfULxIJicKmcxF98Ce7Fw/NhFfRt2ZGFJ3hwg
	Uj/vbBTriDnl6d+sJ0eg+v7i/ERmUmXZBVulsXzrgSzdAgNlKmSdoUNbXD3FNaW8FKJ9Rkg1ThE
	GW51qqGVZ+WnYUbrnsHvkhmL4sRS1dqanQuPJq8wH8n7os6K27O1KX9K1+yHm4QVXDhNJSvO0ou
	9QlLw9rIMwb6UN8PLih9w9jrx/zy0WFUIiABoZQCXi5103uCjnjAzHlhZjC5P2valazxFKXepUK
	wzXdwZbmACce8y30RpGySOYDztqbmmuk1BQjkHlylqIgJ1mAyo3KgI0xKC202MxEvc/kk=
X-Received: by 2002:a17:90b:3505:b0:380:8bb9:aba0 with SMTP id 98e67ed59e1d1-3808bb9ae25mr554144a91.1.1782830119419;
        Tue, 30 Jun 2026 07:35:19 -0700 (PDT)
Received: from cchengyang.duckdns.org (36-226-206-10.dynamic-ip.hinet.net. [36.226.206.10])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38094d742c3sm111891a91.13.2026.06.30.07.35.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 07:35:19 -0700 (PDT)
Date: Tue, 30 Jun 2026 22:35:08 +0800
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: Andrea Righi <arighi@nvidia.com>
Cc: sched-ext@lists.linux.dev, Tejun Heo <tj@kernel.org>, 
	David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>, 
	Ching-Chun Huang <jserv@ccns.ncku.edu.tw>, Chia-Ping Tsai <chia7712@gmail.com>, chengyang.chou@mediatek.com
Subject: Re: [PATCH v2 sched_ext/for-7.3] sched_ext: Replace open-coded event
 lists with SCX_EVENTS_LIST
Message-ID: <20260630223257.G4ee4@cchengyang.duckdns.org>
References: <20260630140645.8855-1-yphbchou0911@gmail.com>
 <akPSxgP6LKir2OrX@gpd4>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <akPSxgP6LKir2OrX@gpd4>

Hi Andrea,

On Tue, Jun 30, 2026 at 04:29:26PM +0200, Andrea Righi wrote:
> Hi Cheng-Yang,
> 
> On Tue, Jun 30, 2026 at 10:06:23PM +0800, Cheng-Yang Chou wrote:
> > Three sites enumerate every scx_event_stats field by name:
> > scx_read_events(), scx_attr_events_show(), and scx_dump_state().
> > Adding a new SCX_EV_* event requires three separate manual edits.
> > Missing any one silently drops counts or omits the field from
> > diagnostic output with no compile-time indication.
> > 
> > SCX_EVENTS_LIST(SCX_EVENT) in internal.h becomes the single
> > authoritative list of event names, so all three sites stay in sync.
> > 
> > No functional changes.
> > 
> > Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
> 
> checkpatch.pl is complaining a bit:
> 
> ERROR: Macros with complex values should be enclosed in parentheses
> #62: FILE: kernel/sched/ext/ext.c:4964:
> +#define SCX_EVENT(name)	at += scx_attr_event_show(buf, at, &events, name)
> ...
> ERROR: Macros with complex values should be enclosed in parentheses
> #116: FILE: kernel/sched/ext/ext.c:10267:
> +#define SCX_EVENT(name)	events->name += READ_ONCE(e_cpu->name)
> 
> Not critical, but maybe it should be nice to clean this up.

Ah, thanks, I'll clean this up.

-- 
Cheers,
Cheng-Yang
