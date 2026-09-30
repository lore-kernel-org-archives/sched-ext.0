Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A7C4C77B4
	for <sched-ext@lists.linux.dev>; Wed, 30 Sep 2026 11:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790769083; cv=none; b=ZwPWn7eZOXYJd/jH5klR2JGq/LptiSpYczEHtADCh58rXHoLXRv/m44akgtLWce88qAD2IoLiS8Ov4A4Py+bpDTn89tRphstt7oUVZEm15xpyGY2YOa5cezG37XmkTzW1GmYj2Z8cICICexVIYYH99VbDD6jcfuOKbF03T01EeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790769083; c=relaxed/simple;
	bh=I8/hLFvp+4rY4bmtJJoZKXtd5wuy/MyydoTfZLg4T+w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Q+/VT1dY+thPj1EhI6KbaA1/7Gt5L+/vfVs1GSIKa1OD0Yvuu+aA5mAt6i88EiNBSEMWY11OtT4k5NxItZWcY2zq7JkZVuhMASkzJS4u012JRKEMZkWYaw5nBV2NnNW2zmka5f850BC91giriKMxO5xIHv4UelBSsIBS4m38uRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GbaZ1rEv; arc=none smtp.client-ip=209.85.221.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GbaZ1rEv"
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-48afe67dfc2so543965f8f.1
        for <sched-ext@lists.linux.dev>; Wed, 30 Sep 2026 04:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790769081; x=1791373881; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=I8/hLFvp+4rY4bmtJJoZKXtd5wuy/MyydoTfZLg4T+w=;
        b=GbaZ1rEvkLzCL5UXZ3E8cbM3TEUJRxOsP1JUEqVa3m6lBXx9fOOyrtFCcRR7q0r7VH
         d8j95/7ah62AHCyGweUgsPvaM8w+6eF/zxKDVPBRb4NkXR6m9ltCRNc6MiLqaST78e5s
         n4kVdQzEKDRQCbfKnZbzc76vVRUgOWrhgNhv8jJmJMxqYTBO9yFpwzZ0I5KZmrid3fnB
         peCyyS2/WYdJ0mTNolbJjM1eKlwESsKkth1EQoOduricaKyzFVQnuiNO7+dyPVjJQ8EG
         3tHl7NJavijzvIip4Gg2stPzUB+npIHdXbIAgdb6ZzlQfeSN98E/98PN1d5G+T5WboTA
         MfQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790769081; x=1791373881;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=I8/hLFvp+4rY4bmtJJoZKXtd5wuy/MyydoTfZLg4T+w=;
        b=2IJiEiaYsEeVKIBRsOzqlnc7AzKDEWgwMKRSzldJmgas2So1bK22TWJv4ysSjI+mhZ
         jGUcr9KZFKU5tebih3Gc1llXnxRe+M7VUDQ/MGxPeVGxZVTpYBpxySUsuKODeMfeCz85
         /Jng7MWN3WliLF7KYltiT0kiD/5ZHhgknbrJTL1ehxSRqQZTl9nAvSe0wjSK5KcQI7Iu
         e4oC8WHppn8/eRbmZSVQPYNO8f+rVKTiRglpjsqzN3YhGI232wBJlnU9TfFboWd7ymCC
         /22yp+KJrcMfw/eVzHFRm3Co+xGt9lFCegz0lrZ8QUllnSOq+Mig28Sqx09Zd9J+OVES
         5+5g==
X-Forwarded-Encrypted: i=1; AKwUvBxTDoYWxvR/Xpdrs1owHgyze550Z4sZUn1WWc+T9LlwzxZanbNRwM/UhX2izwp/ECIiqkZWekybbig=@lists.linux.dev
X-Gm-Message-State: AFuF++mvSDAhyKwD5b6mGyElkAq5+OK3sr609Dnd0WpB/wfrIrvWWNJL
	Tu61BCiXuXmPpbLhvrxIQZ1nBu5Vnbt3RCuaaHGHMQCKHb+kyHa8UTop9mvBuGBeuzlbmiY0Wfp
	xfKA5eK/40nNrLA==
X-Received: from wmpr18.prod.google.com ([2002:a05:600c:3212:b0:49e:6583:68ec])
 (user=jpiecuch job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600d:82c4:b0:49c:e37e:4389 with SMTP id 5b1f17b1804b1-4a01b188e38mr21977855e9.4.1790769079600;
 Wed, 30 Sep 2026 04:51:19 -0700 (PDT)
Date: Wed, 30 Sep 2026 11:50:41 +0000
In-Reply-To: <arwGoJF3PMV7llAK@gpd4>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260929161730.185271-1-jpiecuch@google.com> <20260929161730.185271-2-jpiecuch@google.com>
 <arwGoJF3PMV7llAK@gpd4>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260930115044.337291-3-jpiecuch@google.com>
Subject: Re: [PATCH 1/3] selftests/sched_ext: Add a test for ops.dequeue() on
 remote local DSQ moves
From: Kuba Piecuch <jpiecuch@google.com>
To: Andrea Righi <arighi@nvidia.com>
Cc: Kuba Piecuch <jpiecuch@google.com>, Tejun Heo <tj@kernel.org>, 
	David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>, 
	Emil Tsalapatis <emil@etsalapatis.com>, sched-ext@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, Sep 29, 2026 at 08:42:40PM +0200, Andrea Righi wrote:
> We can probably fold the this into PATCH 3.

Yes, Tejun asked for the same. In v2, the test and its Makefile entry are
a single patch that comes after the fix.

Thanks,
Kuba
