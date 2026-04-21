Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB9326FD97
	for <sched-ext@lists.linux.dev>; Tue, 21 Apr 2026 13:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776778273; cv=none; b=oyv2gECjqYe/YyNto/FpEyfwEJPj3epZVgA4c0W4g3NnRpIEhUGQcRYGa3kDkbVZ3eKQqXH044TYLC9y+xjP1zVO63bV004izdVGjcQT9w/CNdCYNd8N/WzLWgcRFoPquFz81lK7e4uio2nZhp3O1UuxLRRVzy0LjNyig1QAbYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776778273; c=relaxed/simple;
	bh=5OXh9qwGgCUnsQZ5sWiznN1+yTPaVaMMMmX8wUq076E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HV66QeLwxlA7RWBzIaEWV77Bib+cHJCv9PXPp6c2smtUhQZdX1b2CcyLh7MiO0WOUA8qctjco02/WyaE67X247nszjLo4oYmagS6ggwbCpgcx9MpjnlwmDS2+6cV4oKhbJs89lu04auGhv6NE4dxpIJT2lD9sOGbyW3imy+C1SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=deGgKp9h; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="deGgKp9h"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c70f91776fcso1630638a12.0
        for <sched-ext@lists.linux.dev>; Tue, 21 Apr 2026 06:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776778272; x=1777383072; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WCX5Uszzip8DRdXjVUDmJ4cf+a8xcm2wuC/F0AJWc0E=;
        b=deGgKp9hG0vPiN9RYW8BHkYu3tcWiqJwG2bjBrKZq742e17BMHc4DWOngEootlz3nj
         WpbZwIm15Yh/w9o+ZLCflg40ane87CJQucVqe55trUNPb/dhhms2vGcvm5tOLZ6YLzgb
         vfKaAenF4UaFLiCpMs9qUmhJH+BhcEtpVfrZh37an3kG38QIEymrT1ZYgdl6V2zuK0oQ
         953GxBUG3wbFp+DSXJvq3MopEb5lkLTHoehiy2BZ0hZv5dRMh+aQSfJFoqRpFN5+fx0q
         eyrtdoHk2mOrWIAXOw2R3QzM8U+07EKF7xAs51E9bPzeqVOnryHRn46SdnkCvUiy2fEe
         t4kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776778272; x=1777383072;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WCX5Uszzip8DRdXjVUDmJ4cf+a8xcm2wuC/F0AJWc0E=;
        b=MBzO2gvwIuSTfyHJMxoTZZRPl1tRt6UNSPCQbQgY239jM31DMyBLYDax7Z2lAf4EyF
         yYPrLWxwMaNB49k4khDfZgnfz+ADN/o4Z2L8tMcz9qd6n0mo5BXqLb1psafXENGDX8Wa
         qCVdfZmZ9yKUndH/Le/ONN/g4GgQCytB59zbHvRlHnwN4+Gdop/3ZcDT/hLDKpH9Q4ro
         Du76e7y3Qh1vNlsKoHp+YW1eVf7IithoWH5CF3u8P12q6W5pvtzxEttBjYAir+386zLp
         uEOIoPMJWEnhuiB/QIg1C2bg/iZcxZgaXddTXjdzzDHe5XKVPjSThOzXQqtdWvp2YWgF
         L8Hw==
X-Forwarded-Encrypted: i=1; AFNElJ8cAkk7bFJ2Iybs/mpf3YJKvenFKXspTXltNmR30x3YwYL4yw2ymAiTC1J6xOk4hEcW6fJjskD1oJI=@lists.linux.dev
X-Gm-Message-State: AOJu0YxvVjJJZZniqbXBLhrtpN1CUFh5gq4vgE38bjRpyDth5VZEPWsL
	dfqs4+KkWOnyIbhmky7PG9blkLUKMLZBXG1r/dZCtq7XZmur3+cnqTCv
X-Gm-Gg: AeBDietPNN4MgHnjR4NfBGjmMOpWAIQ+rU76NuNtIoEzWMz27AI/WPDXG07XufHLtn7
	LCJM6rE0v2DEnmqrZ+YpfgBncY0z7b4LPwSGmTVrblKnJzZ7JmWJdxDrhGO7Mf24nF2Qo0Gqr3S
	oyIDyyayCCabQzPr+2Cv/jKZWVA1Mtx/awfW/DxR9HmxjrE6eqC5XrHhTkTXhClh9scvNIbH3+0
	Kmu3woEoCAw7hY2xJLWddrBcL8TwqT7VC+OOAbkwQJ8H6R/fnfi3hn26cu1b/EdvFRa0GTJ51mo
	2VXm2HIi7FxmmvRxF1D6/HMVEbDq/3FUU2vEd1cDYR3GJHwSvHR4jZn++EVysa2vFfbiPLxBo3r
	EYo6r56r/4lOUxK3m6LoTeM6jNL2ojUlhuyge2glG4d+jtIXp9EGGFvqgjsxA4kQxul0GEsxwBH
	j9lj5YktGxlQs1SQbnSdKV0W7jElGATgeyRuNElytLryRW380YLzzTxop9Xk8oW7XwDx+HSFjEo
	xZeQ8CDBCbhvL4h
X-Received: by 2002:a05:6a20:e211:b0:3a2:7ef4:81df with SMTP id adf61e73a8af0-3a27ef485b0mr10491480637.26.1776778271506;
        Tue, 21 Apr 2026 06:31:11 -0700 (PDT)
Received: from cchengyang.duckdns.org (36-225-97-241.dynamic-ip.hinet.net. [36.225.97.241])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7976f9cabfsm11703580a12.9.2026.04.21.06.31.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 06:31:11 -0700 (PDT)
Date: Tue, 21 Apr 2026 21:31:07 +0800
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: Tejun Heo <tj@kernel.org>
Cc: void@manifault.com, arighi@nvidia.com, changwoo@igalia.com, 
	sched-ext@lists.linux.dev, emil@etsalapatis.com, linux-kernel@vger.kernel.org, 
	Ching-Chun Huang <jserv@ccns.ncku.edu.tw>, Chia-Ping Tsai <chia7712@gmail.com>
Subject: Re: [PATCH 01/16] sched_ext: Rename ops_cpu_valid() to
 scx_cpu_valid() and expose it
Message-ID: <20260421212801.Gee7d@cchengyang.duckdns.org>
References: <20260421071945.3110084-1-tj@kernel.org>
 <20260421071945.3110084-2-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260421071945.3110084-2-tj@kernel.org>

Hi Tejun,

On Mon, Apr 20, 2026 at 09:19:30PM -1000, Tejun Heo wrote:
> Rename the static ext.c helper and declare it in ext_internal.h so
> ext_idle.c and the upcoming cid code can call it directly instead of
> relying on build_policy.c textual inclusion.
> 
> Pure rename and visibility change.

Reviewed-by: Cheng-Yang Chou <yphbchou0911@gmail.com>

-- 
Cheers,
Cheng-Yang
