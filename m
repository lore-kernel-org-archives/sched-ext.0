Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38969471275
	for <sched-ext@lists.linux.dev>; Fri,  9 Oct 2026 14:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791554854; cv=pass; b=r4/7aroAeuioJDAhRVv4k1izsA0E/0gsZSychCekK6UUXAaRAU5SmJVFyejSo8qiIhajGVLLUBNnEk6/Vlj+JV5oLFYHyasy6fPz8SUbQAFU0K+c+q9Yy2TatGp5CTypxGwC79ZhsWKCEQ91zwysh+VYGJAh9oOmZNyTxbcrd+s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791554854; c=relaxed/simple;
	bh=b4rMtXSyvgzVOdG4ilTjHKgvnbsQsAYQrWnRRDEOIYQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EIOP39lRK5TeUYCwzgTqGkOdei12y8MRz4Rax4SyGwjwW4VvbGf6BWuZESaSitTGqxR9VwThOOK5Epgsv+YlsN1648E6ou4JSZRBIzsIfGnPHnECSq57nmUiM4Ui3rBNRsUDWnfFBgrjDwkoRmjGSeARs+a0rygWmis+F7iagYI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ti8BxeoR; arc=pass smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ti8BxeoR"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c2e2007dd8bso678011366b.2
        for <sched-ext@lists.linux.dev>; Fri, 09 Oct 2026 07:07:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791554848; cv=none;
        d=google.com; s=arc-20260327;
        b=cgKvKhpycs1R+gbY6yTZ0XJtx8g6o8pGiizeywfdsT9N2/j9RV+ii1ccn60NsJ43BC
         a1MCmzY+BF0fMLRM540LDQyvW/AV+G4S1YhfQSltMD1Ni2ekIprEPBu/vnr6oXsbVUcx
         w0/lUvFB3qdW8MLnaZk8le8oaeTgS4okh3kcJNOrNGcYUbHKCEfpzh8fUMk7Q5lR00v/
         ZOwLf+keCV3qxGzFNTTJgp/3iicJ+caJ5ijLEr6wBw3mTML1nm8hapM2uRvPzxHsL++d
         x/16UiO0pISW3rZNnhGuipdfXFaW92Le8UVB4LvxdVNG+IoIGpBz/SsfHvBprSY2aJ5e
         fAhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=aPA7l/cDhFmUwI+RbBKmxxOCeGT4OK8rl1qxZjkWe6o=;
        fh=ufIUl7iDSDKa3e6zowTu2/L59IouDbEJOmPaRFhDptc=;
        b=AhC2aTdC0Px8Lu9oxH1of9uw08dcICAINKttT3+oUMQ24QfoCwZKGHlxdqW1QVUUkZ
         5tO+vikOX4UI6/GnydoEQF6x7tCRGOEVd6Mn1vKfW6Gz8+lM2cdpELYSNtJGkkO3UV94
         VRiYdNEVxFNCp1FksrMJSLf3oQtyK+wd0SKG8DK09Q24RBYqwwAKfFz/+3wnYEuOoKH3
         fpzQorHbZ6FjOA3jDFsIymQrWWI0W7o/0/lIMSlMtHw1kaXS2uAG0Kv0l7rjkhy8eJ9/
         CWtDsClgKC3oxjGY2T6/KDG2TyFV4dJAY3W5dyrW5vetrY0ZJQW2FAjp5Pos7iYm14Dt
         m5QQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1791554848; x=1792159648; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aPA7l/cDhFmUwI+RbBKmxxOCeGT4OK8rl1qxZjkWe6o=;
        b=ti8BxeoRAsHav6C/KWuE5M8E7psuxuwy53Sl7Pmo/Qk0dvzJvsqO/sBwoM/w7uug3Z
         48GeyidmX7zPH7CUKSJdAfEENADVoRbRf7J3wDXrQgF9Pf5zdrQnm16YCjlpugEzwYVU
         d7d2bQYd0ydrxeAuJiOWdUQmrqmru9P/dASfhE6XsaWeAveFZnVxId/hJXDCIkHvyRKN
         +/WMCzdeP0T/3/WNK79EqqA2N2k1NvdB0RsStKK/mKZ3oq79bMiKH272gk6XlSUfNm0K
         KeCc7sl4o9WJfJbHqH5rRzNXUdU6v4Q3owqsi/C3j8mVSQe7fKDX1EC7OzMDi5JzBDDI
         oRPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791554848; x=1792159648;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=aPA7l/cDhFmUwI+RbBKmxxOCeGT4OK8rl1qxZjkWe6o=;
        b=pACA0eGIUMfxszwXTJU11CqCb1kZ0JZFhhdxElzxblccISwy5FBvkPCOU+Y3ANEd14
         gHNx7IwMf093RBNlWHxwh5yozO9iS6i1grdu8+LEauDjPho1XkezJU2HwfFfSYjv6bBu
         6os8QsaHUT2v/3+gX+MvYtZf4Tk4S9Ls5GJ0ZZaWhxa0nkEkwA/rMPTceK4JjGtP5G3U
         Qiu/UfEzJcqWdSThnpN/N8txPxuNSzW7t65Z4ln23qvAZEbXw5djsfDH8wd80DW/J/WE
         /R9i1CyCN6NYX1vZixn3UXWacIS2UX0/y7GLgm081hYXxYEza9WNkCTjTY6QfMB7fBPc
         CtBQ==
X-Forwarded-Encrypted: i=1; AKwUvBwf1zvc0pQHQHc6scTtw55rXdHN7Da23yNielebJCltVeyC3qKhyOu6Xo8ZXWGWTCIC06kCqovUkbg=@lists.linux.dev
X-Gm-Message-State: AFq9FYJEi7DwnXfGETTUkF++5A813mqIcgdqxRvP7niHdMXLCHbYqBNW
	LCNEbKNddytsCw/K2GDq6Nq3cgd9Q4ydVsvwBwu5ymvRgNq0OQZgVvHiNoLM2OmPwmJj2SRaPV+
	IoiccpPSXa75WtXEK6Jsq3l/w+iPLkvTjqOF0pCwHbg==
X-Gm-Gg: AYBFou1qMpyBEl/gPCrUOLs72iBpsRMfb8xYFtE9bHSlolu8UD2ZxyiBSLpxWvV/emG
	zmzNJJLiUWsPBKZA3PKcYPi+qOg8RvEa+XqbUlGsDHHuN6h4kKI9eGcqjQmUIndSbQtIRVS6OfZ
	e+WcRL8Uc7e5SSSmcRhHdBtKhZN6DfKvBR+eFOOk4VwxfcDLS836ojBOnABoo0ECwx/cx1AwEGR
	T46tFKaPcT787aVamPyyH+2ZmQQx+47BMlc7p/PimAym7ygKWHHeZNCjBDQnu/aJfS5QLManDfk
	MqWcrrpjnJgaPkDNBXEdgvD73ogRJ8FlUljIRAlv3Si+EbF0PivtE/cYAFQoZZWk/Y0mOu0/wRN
	cdM/vOMqyoPRczWaj+4V1Cg==
X-Received: by 2002:a17:907:9618:b0:c24:4128:c19f with SMTP id
 a640c23a62f3a-c31a9d0a1efmr229344366b.11.1791554848238; Fri, 09 Oct 2026
 07:07:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20261002154415.2270586-15-vincent.guittot@linaro.org> <20261009111627.4861-1-kayracizmeci@gmail.com>
In-Reply-To: <20261009111627.4861-1-kayracizmeci@gmail.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Fri, 9 Oct 2026 16:07:16 +0200
X-Gm-Features: AclHuK93qwibmCeDReqU3VlqkUs03L7RaL6WzAc8RexM6-c3eryuJOq2Yp8j9Do
Message-ID: <CAKfTPtCwv5f1D0uDqa2vePcYzavgut1W1Mab7pz3o7a1vTYO9w@mail.gmail.com>
Subject: Re: [PATCH 14/18 v2] sched/fair: Enable push task for preempt short
To: Kayra Cizmeci <kayracizmeci@gmail.com>
Cc: arighi@nvidia.com, bsegall@google.com, changwoo@igalia.com, 
	christian.loehle@arm.com, dietmar.eggemann@arm.com, juri.lelli@redhat.com, 
	kprateek.nayak@amd.com, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, lukasz.luba@arm.com, mgorman@suse.de, 
	mingo@redhat.com, peterz@infradead.org, pierre.gondois@arm.com, 
	qyousef@layalina.io, rafael@kernel.org, rostedt@goodmis.org, 
	sched-ext@lists.linux.dev, sshegde@linux.ibm.com, tj@kernel.org, 
	void@manifault.com, vschneid@redhat.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 9 Oct 2026 at 13:16, Kayra Cizmeci <kayracizmeci@gmail.com> wrote:
>
> > Enable push mecanism for the preempt short feature which is the
> > 1st feature using it.
>
> IDK typo count of 'mecanism'. It would be cool if I counted the typos I found in this thread.
> They're so important. But, I didn't counted them
>
> > @@ -3475,6 +3475,9 @@ static void partition_sched_domains_locked(int ndoms_new, cpumask_var_t doms_new
> >       sched_energy_set(has_eas);
> >  #endif
> >
> > +     if (sched_feat(PREEMPT_SHORT))
> > +             static_branch_inc_cpuslocked(&sched_push_task);
> > +
>
> Well, as I checked it seems like first user of the push 'mecanism' can't be disabled.
> This could be the correct behavior too tho? If we want to open it and do not let it
> close even when PREEMPT_SHORT is false...

I didn't want to make the push mechanism enabled by default but only
when something uses it. Short slice tasks are the 1st user.

I wanted to keep a simple way to disable it at boot when it isn't used.

>
> But I think you wanted to connect this to PREEMPT_SHORT, no?
> Well if no, then well I have no words. If yes, I have.
>
> I done a quick test, adding this line to here:
>
>         if (sched_feat(PREEMPT_SHORT))
>                 static_branch_inc_cpuslocked(&sched_push_task);
>        pr_info("push key count=%d\n", static_key_count(&sched_push_task.key)); <--- This
>
> And booting up the kernel. Playing with CPU1's online status and closing PREEMPT_SHORT.
> And...
>
> [    0.967146] push key count=1
> 0
> 1
> [    0.967146] push key count=1
> [   42.408439] push key count=2
> [   42.475103] push key count=3
> NO_PREEMPT_SHORT
> 0
> 1
> [    0.967146] push key count=1
> [   42.408439] push key count=2
> [   42.475103] push key count=3
> [   42.562426] push key count=3
> [   42.619255] push key count=3

This should not happen. I will fix it


>
> This is a bit messy since it's raw, but as you can see even when we
> close PREEMPT_SHORT this not decreases. It just stays on and grows over time.
>
> That's what I'll say, maybe I'm missing something.
>
> Thanks,
> Kayra
