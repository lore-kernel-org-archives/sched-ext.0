Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06BE3932DC;
	Sun, 10 May 2026 13:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778421332; cv=none; b=blrcUaEOx/BoNwmOlJThTrPCvJEAEe5rom454O2b1Z6ePfSN12QHaU4CAYbAWXZNFSTnTUonj4nrPT1wigyoSTAsuPevtFnF6PNQCKqVe4MuBNGdYwlmC/g9z2CCZtAXBOngWFYIwa1KgqFijXg4DI+Rzu9mv4+8sX6RMdyYtVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778421332; c=relaxed/simple;
	bh=FxRKigehiLGN3UQfHHA5rga4kgJBTzlRe/0ULSv66bw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iSqbZNkCR36raXFu27RP+mFeZ9m0iGgk0z1M52+kgGhoTF1ZjpWhEgmqh87aNOMdQ69Fg7H7ObITK9dvOx/OvA1uXVYrg0HFICdYgMZSd4rwQY7Svo6X9I1QBJvWF0DvTFHISO+ziqVvw31oxNZnRkfJOobiApsoDvvqbKybrVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pCvx/nXr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pCvx/nXr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67DBAC2BCB8;
	Sun, 10 May 2026 13:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778421332;
	bh=FxRKigehiLGN3UQfHHA5rga4kgJBTzlRe/0ULSv66bw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pCvx/nXr3aBfdCtbSjVXkvK6db2RXP1rJBwcuZUOg/m4AfqSC+MXX5L99Gy/zxvK7
	 OL2/C7LFEVsi1KnACuq317jmOBGlLQkvjuOfP+i/DKVnQiMSsPotuA+U/VHdvFy/Wr
	 HHnCkWUkYbpKlx2eeSHaPLIHtOiiCD1ZOYcd+uB2lFUOOP0OtVkTV9s2XNkA5Vz1Fv
	 BcMnSp1CMc5zV5N/zXhwJipFkZw97amsZ/b937CphnkkGpEhFO/6IuUcWoVOs3YwPc
	 SlLu268tKdCxKaQVb5Xeg3QHB0cyOzMD4wceprF0CXoCkgoD/1AJAdfBUBt5IWnj3w
	 808ZNjmzyhzIw==
From: Tejun Heo <tj@kernel.org>
To: suzhidao@xiaomi.com
Cc: void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	emil@etsalapatis.com,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2] sched_ext: Fix sched_ext_dead() race with scx_root_enable_workfn()
Date: Sun, 10 May 2026 03:55:31 -1000
Message-ID: <20260510135531.2291252-1-tj@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260506054001.1105522-1-suzhidao@xiaomi.com>
References: <20260429133155.3825247-1-suzhidao@xiaomi.com> <20260506054001.1105522-1-suzhidao@xiaomi.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

Thanks for the report and the patches. The same race window also
affects the analogous sub-sched paths and the wrapper-disable paths
trip on the NONE state that scx_fail_parent() leaves behind, so I
ended up taking a more invasive route - extending the task state
machine with SCX_TASK_INIT_BEGIN and SCX_TASK_DEAD - rather than
continuing with your localized fix.

Posted as a 6-patch series:

  https://lore.kernel.org/all/20260510074113.2049514-1-tj@kernel.org/

Thanks.

--
tejun
