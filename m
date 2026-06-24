Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B27E3822A2;
	Wed, 24 Jun 2026 20:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782331994; cv=none; b=NT7M8ukwHmpvc+l8u2YdBmLKxYvO6YJ9QMhTQeOn8ZuJ8hlVuM8VjQ9TkyyqkdR94cZMUBFd2DSPNxNL9AfxflJH1WNRoG85aYWLOR/wi7CK40nmVSYE1/yXGJdySkXKdPGHRznK9WEyMY9GAUsWx2a+x/7v6UaacnU8tBIptAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782331994; c=relaxed/simple;
	bh=286DKP7EYWnggjEkXb9NUKoDBTmGKiRd8QyJHJItIKg=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=revTh/87JbSrT0QgYHUX8c3myxXunM25ClVKzcF0FR1kpwRYLTgr+/A/UaOHpQTkEkpQlxb7CF1pLvZtkJlDjvprvrrTvwmgZ4C/rOE3cbvUB6GLFJuBPGlcI7qp1fuY5IsczNP22/IQOi9XQR6hNYqNAEjQKVIPCJru3rQNMGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UTMUreqd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UTMUreqd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B3E51F000E9;
	Wed, 24 Jun 2026 20:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782331992;
	bh=286DKP7EYWnggjEkXb9NUKoDBTmGKiRd8QyJHJItIKg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=UTMUreqdL43PJcFp0/1xlwHek9W5fyDisnkUzebZsPGlKSdBX39pKA0ts6a+Uasvx
	 ij9LULIukvvTzFjNpsVWqUuzUDINo/Z/HQz51nNOrzir/oCY9HV5Mv7HZglGHsN87A
	 UTouXujp3JpAMAOlVtgjs/YZIU6jz1Xcsq/0LSq/nzJjQEgZgq2q5d2sFenwDqKvcR
	 nGP/CkEsHc+ymvaDT8SBSt0BMn/KFtvykWHLn/xuRc+ywLeuk2FVkL7YtN3UnmjsKC
	 NcFkFiTRNlBxc4MK7mpVsITt7q4YPEXCC6sZ1swFLIdQzRzEoYaQYA9DBORiIiOos+
	 /adhWvxvyV7vQ==
Date: Wed, 24 Jun 2026 10:13:11 -1000
Message-ID: <062ddcde2deecba66edb33c8ff50da7b@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Christian Loehle <christian.loehle@arm.com>
Cc: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>, Hongyan Xia <hongyan.xia@transsion.com>,
 Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>, sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org, Emil Tsalapatis <emil@etsalapatis.com>
Subject: Re: [PATCH] sched_ext: Remove deprecated scx_bpf_cpu_rq()
In-Reply-To: <20260619155920.156257-1-christian.loehle@arm.com>
References: <20260619155920.156257-1-christian.loehle@arm.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Applied to sched_ext/for-7.3.

Thanks.

--
tejun
